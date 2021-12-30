const std = @import("std");
const vm = @import("memory.zig");
const VirtualMemory = vm.VirtualMemory;
const Allocator = std.mem.Allocator;
const macho = std.macho;

const Symbol = struct {
    name: []const u8
};

const RelocationTask = struct {
    segmentName: []const u8,
    sectionName: []const u8,
    isectStart: usize,
    isectLen: usize
};

pub fn loadExecutable(allocator: Allocator, file: std.fs.File) !VirtualMemory {
    const reader = file.reader();
    const seekable = file.seekableStream();

    const header = try reader.readStruct(macho.mach_header_64);
    if (header.magic != macho.MH_MAGIC_64) {
        std.log.err("Not a valid 64-bit Mach-O file", .{});
        return error.FileError;
    }
    if (header.filetype != macho.MH_EXECUTE) {
        std.log.err("Mach-O file is not an executable", .{});
        return error.FileError;
    }
    if (header.cputype != macho.CPU_TYPE_ARM64) {
        std.log.err("Only ARM64 machine code is supported", .{});
        return error.FileError;
    }

    var segmentsList = std.ArrayList(vm.Segment).init(allocator);
    var symbolList = std.ArrayList(Symbol).init(allocator);
    defer symbolList.deinit();
    var relocTasks = std.ArrayList(RelocationTask).init(allocator);
    defer relocTasks.deinit();

    var i: usize = 0;
    while (i < header.ncmds) : (i += 1) {
        const cmd = try reader.readEnum(std.macho.LC, .Little);
        const size = try reader.readIntLittle(u32);
        try seekable.seekBy(-8);
        // std.log.scoped(.macho).debug("{}", .{ cmd });
        switch (cmd) {
            .SEGMENT_64 => {
                const command = try reader.readStruct(macho.segment_command_64);

                var sectionsList = std.ArrayList(vm.Section).init(allocator);
                var sectionNum: usize = 0;
                while (sectionNum < command.nsects) : (sectionNum += 1) {
                    const section = try reader.readStruct(macho.section_64);

                    // Seek and read the data contained by this section
                    const pos = try seekable.getPos();
                    try seekable.seekTo(section.offset);

                    const mem = try allocator.alloc(u8, section.size);
                    try reader.readNoEof(mem);
                    try seekable.seekTo(pos);

                    try sectionsList.append(.{
                        .name = try allocator.dupe(u8, &section.sectname),
                        .start = section.addr,
                        .size = section.size,
                        .mem = mem
                    });

                    if ((section.flags & macho.S_NON_LAZY_SYMBOL_POINTERS) == macho.S_NON_LAZY_SYMBOL_POINTERS) {
                        try relocTasks.append(.{
                            .sectionName = try allocator.dupe(u8, &section.sectname),
                            .segmentName = try allocator.dupe(u8, &command.segname),
                            .isectStart = section.reserved1,
                            .isectLen = @divExact(section.size, 8)
                        });
                    }
                }

                const segment = vm.Segment {
                    .start = command.vmaddr,
                    .size = command.vmsize,
                    .name = try allocator.dupe(u8, &command.segname),
                    .sections = sectionsList.toOwnedSlice()
                };
                try segmentsList.append(segment);
            },
            .SYMTAB => {
                const command = try reader.readStruct(macho.symtab_command);
                const pos = try seekable.getPos();
                var sym: usize = 0;
                while (sym < command.nsyms) : (sym += 1) {
                    try seekable.seekTo(command.symoff + sym * @sizeOf(macho.nlist_64));
                    const nlist = try reader.readStruct(macho.nlist_64);
                    //std.log.info("{x}", .{nlist.n_desc});
                    if ((nlist.n_type & macho.N_EXT) != 0) {
                        try seekable.seekTo(command.stroff + nlist.n_strx);
                        const str = try reader.readUntilDelimiterAlloc(allocator, 0, std.math.maxInt(usize));
                        _ = str;
                        if ((nlist.n_type & macho.N_EXT) != 0 and (nlist.n_type & macho.N_STAB) == 0) {
                            //std.log.info("str: {s}", .{str});
                            //std.log.info("n_value: {x} -> {x}" ,.{nlist.n_type & macho.N_TYPE, nlist.n_value});
                            const libraryNo = nlist.n_desc >> 8;
                            //std.log.info("defined in {x}", .{ libraryNo });
                            if (libraryNo == 0) { // defined in current module
                                const address = nlist.n_value;
                                _ = address; // TODO: add symbol to section
                            }
                            try symbolList.append(Symbol { .name = str });
                        }
                    }
                }

                try seekable.seekTo(pos);
            },
            .DYSYMTAB => {
                const command = try reader.readStruct(macho.dysymtab_command);
                const pos = try seekable.getPos();
                std.log.info("{} / {d}", .{ command, symbolList.items.len });

                for (relocTasks.items) |reloc| {
                    std.log.info("Relocation task on section '{s}', start at {d} for {d} items.", .{ reloc.sectionName, reloc.isectStart, reloc.isectLen });
                    var isym: usize = reloc.isectStart;
                    while (isym < reloc.isectStart + reloc.isectLen) : (isym += 1) {
                        for (segmentsList.items) |segment| {
                            for (segment.sections) |*section| {
                                _ = section;
                                try seekable.seekTo(command.indirectsymoff + isym * @sizeOf(u32));
                                const index = try reader.readIntLittle(u32);
                                if (index != 0x80000000) {
                                    //std.log.info("{d} / {d}", .{ index, symbolList.items.len });
                                    //const symbol = symbolList.items[index];
                                    //_ = symbol;
                                    //std.log.info("{} = {s}", .{ index, symbol.name });
                                }
                            }
                        }
                    }

                    allocator.free(reloc.segmentName);
                    allocator.free(reloc.sectionName);
                }

                try seekable.seekTo(pos);
            },
            .LOAD_DYLIB => {
                const pos = try seekable.getPos();
                const command = try reader.readStruct(macho.dylib_command);

                try seekable.seekTo(pos + command.dylib.name);
                //const str = try reader.readUntilDelimiterAlloc(allocator, 0, std.math.maxInt(usize));
                //std.log.info("dylib path: {s}", .{ str });

                try seekable.seekTo(pos + size);
            },
            else => {
                try reader.skipBytes(size, .{});
            }
        }
    }

    return VirtualMemory {
        .segments = segmentsList.toOwnedSlice()
    };
}