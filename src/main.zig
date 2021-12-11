const std = @import("std");
const Allocator = std.mem.Allocator;
const macho = std.macho;
const disassemble = @import("arm/disassembler.zig").disassemble;
const VirtualMemory = @import("memory.zig").VirtualMemory;
const objc = @import("objc.zig");

/// Integer parse function for use by the CLI. Instead of throwing an error
/// it will send an error message and return null.
fn parseIntSafe(comptime T: type, buf: anytype, radix: anytype) ?T {
    if (std.mem.startsWith(u8, buf, "0x")) {
        return parseIntSafe(T, buf[2..], 16);
    } else if (std.mem.startsWith(u8, buf, "0d")) { // force decimal
        return parseIntSafe(T, buf[2..], 10);
    } else if (std.mem.startsWith(u8, buf, "0o")) {
        return parseIntSafe(T, buf[2..], 10);
    } else if (std.mem.startsWith(u8, buf, "0b")) {
        return parseIntSafe(T, buf[2..], 2);
    }
    return std.fmt.parseInt(T, buf, radix) catch |err| {
        switch (err) {
            error.Overflow => std.log.err("Base-{d} number '{s}' does not fit in a 64-bit address space", .{radix, buf}),
            error.InvalidCharacter => std.log.err("'{s}' is not a number", .{buf})
        }
        return null;
    };
}

fn argOrNull(args: CommandArgs, index: usize) ?[]const u8 {
    if (index < args.len) {
        return args[index];
    } else {
        return null;
    }
}

fn expectArg(args: CommandArgs, index: usize, comptime msg: []const u8) ?[]const u8 {
    return argOrNull(args, index) orelse {
        std.log.err(msg, .{});
        return null;
    };
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const processArgs = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, processArgs);

    if (processArgs.len < 2) {
        std.log.err("Usage: banspil [executable]", .{});
        return;
    }

    const file = std.fs.cwd().openFile(processArgs[1], .{ .read = true }) catch |err| {
        std.log.err("error opening main file '{s}': {s}", .{processArgs[1], @errorName(err)});
        return;
    };
    defer file.close();

    var vm = try @import("macho.zig").loadExecutable(allocator, file);

    const stdin = std.io.getStdIn().reader();
    while (true) {
        std.debug.print("> ", .{});
        const line = try stdin.readUntilDelimiterAlloc(allocator, '\n', std.math.maxInt(usize));
        defer allocator.free(line);

        var argsTokenizer = std.mem.tokenize(u8, line, " ");
        const command = argsTokenizer.next() orelse continue;

        const argsNum = std.mem.count(u8, line, " ");
        const args = try allocator.alloc([]const u8, argsNum);
        defer allocator.free(args);

        var i: usize = 0;
        while (i < args.len) {
            args[i] = argsTokenizer.next() orelse break;
            i += 1;
        }

        if (std.mem.eql(u8, command, "vm")) {
            try commandVm(allocator, &vm, args);
        } else if (std.mem.eql(u8, command, "b")) {
            try commandB(allocator, &vm, args);
        } else if (std.mem.eql(u8, command, "mon")) {
            try commandMon(allocator, &vm, args);
        } else if (std.mem.eql(u8, command, "code")) {
            try commandCode(allocator, &vm, args);
        } else if (std.mem.eql(u8, command, "class")) {
            try commandClass(allocator, &vm, args);
        } else if (std.mem.eql(u8, command, "class-list")) {
            try commandClassList(allocator, &vm, args);
        } else if (std.mem.eql(u8, command, "load")) {
            // const path = args.next() orelse {
            //     std.log.err("Expected path to a Mach-O file.", .{});
            //     continue;
            // };
            // const f = std.fs.cwd().openFile(path, .{ .read = true }) catch |err| {
            //     std.log.err("error opening file '{s}': {s}", .{path, @errorName(err)});
            //     continue;
            // };
            // defer f.close();
            // vm = @import("macho.zig").loadExecutable(allocator, f) catch {
            //     continue;
            // };
        } else if (std.mem.eql(u8, command, "help")) {
            std.debug.print("- load <path>         Load the given file for analyze\n", .{});
            std.debug.print("- vm                  Print loaded sections and their address\n", .{});
            std.debug.print("- b <address>         Print the byte at the given address\n", .{});
            std.debug.print("- mon <start> [size]  Print a slice of memory\n", .{});
            std.debug.print("- code <start> [size] Print and disassemble a slice of memory\n", .{});
            std.debug.print("- class <class id>    Print information about given class\n", .{});
            std.debug.print("- class-list          List every class present in the loaded executable\n", .{});
        } else if (std.mem.eql(u8, command, "exit")) {
            break;
        }
    }
}

const CommandArgs = []const []const u8;
fn commandVm(allocator: *Allocator, vm: *VirtualMemory, args: CommandArgs) !void {
    _ = allocator;
    _ = args;

    for (vm.segments) |segment| {
        std.debug.print("{s}: {x} - {x}\n", .{segment.name, segment.start, segment.start + segment.size});
        for (segment.sections) |section| {
            std.debug.print("    {s}: {x} - {x} size: {x}\n", .{section.name, section.start, section.start + section.size, section.size});
        }
    }
}

fn commandB(allocator: *Allocator, vm: *VirtualMemory, args: CommandArgs) !void {
    _ = allocator;

    const addr = parseIntSafe(u64, expectArg(
        args, 0, "Expected address argument") orelse return, 16) orelse return;
    std.debug.print("{x}: {x}\n", .{addr, try vm.readByte(addr)});
}

fn commandClassList(allocator: *Allocator, vm: *VirtualMemory, args: CommandArgs) !void {
    _ = allocator;
    _ = args;

    const classListSection = vm.getSection("__objc_classlist") orelse {
        std.log.err("Cannot read Objective-C classes from executable. Missing section '__objc_classlist'", .{});
        return;
    };
    var listAddr = classListSection.start;
    var i: usize = 0;

    while (listAddr < classListSection.start + classListSection.size) : (listAddr += 8) {
        const classAddr = try vm.readIntLittle(listAddr, u64);
        const classRoAddr = try vm.readIntLittle(classAddr + 32, u64);
        const nameAddr = try vm.readIntLittle(classRoAddr + 24, u64);
        std.debug.print("class #{d}: {s}\n", .{i, @ptrCast([*:0]const u8, try vm.getPtr(nameAddr))});
        i += 1;
    }
}

fn commandMon(allocator: *Allocator, vm: *VirtualMemory, args: CommandArgs) !void {
    _ = allocator;

    const start = parseIntSafe(u64, expectArg(
        args, 0, "Expected start address argument") orelse return, 16) orelse return;
    const size = parseIntSafe(u64, argOrNull(args, 1) orelse "10", 16) orelse return;

    var addr: u64 = start;
    var remaining: u64 = size;
    while (remaining > 0) {
        var data: [16]u8 = undefined;
        const slice = data[0..std.math.min(remaining, 16)];
        try vm.readSlice(addr, slice);
        std.debug.print("{x}: ", .{addr});
        for (slice) |byte| std.debug.print("{x:0>2} ", .{byte});
        for (slice) |byte| std.debug.print("{c} ", .{if (byte > 20) byte else '?'});
        std.debug.print("\n", .{});

        addr += slice.len;
        remaining -= slice.len;
    }
}

fn commandCode(allocator: *Allocator, vm: *VirtualMemory, args: CommandArgs) !void {
    _ = allocator;

    const start = parseIntSafe(u64, expectArg(
        args, 0, "Expected start address argument") orelse return, 16) orelse return;
    const sizeString = argOrNull(args, 1);
    const size = parseIntSafe(u64, sizeString orelse "0", 16) orelse return;
    if (size % 4 != 0) {
        std.log.err("invalid size", .{});
        return;
    } else if (start % 4 != 0) {
        std.log.err("not aligned (expected 4-byte alignment)", .{});
        return;
    }

    // If true, print code until the RET instruction is hit
    const wholeFunction = if (sizeString == null) true else false;
    var addr: u64 = start;
    var remaining: u64 = size;
    while (remaining > 0 or wholeFunction) {
        var data: [4]u8 = undefined;
        const slice = &data;
        try vm.readSlice(addr, slice);
        std.debug.print("{x}: ", .{addr});
        for (slice) |byte| std.debug.print("{x:0>2} ", .{byte});
        const opcode = try vm.readIntLittle(addr, u32);
        std.debug.print("{b:0>32} ", .{opcode});
        switch (disassemble(addr, opcode)) {
            .@"RET ", .@"B " => {
                if (wholeFunction) {
                    std.debug.print("\n", .{});
                    break;
                }
            },
            else => {}
        }
        std.debug.print("\n", .{});

        addr += slice.len;
        if (!wholeFunction) remaining -= slice.len;
    }
}

fn commandClass(allocator: *Allocator, vm: *VirtualMemory, args: CommandArgs) !void {
    _ = allocator;
    // See https://opensource.apple.com/source/objc4/objc4-532/runtime/objc-runtime-new.h.auto.html
    const id = parseIntSafe(u64, expectArg(
        args, 0, "Expected class numerical identifier") orelse return, 10) orelse return;

    const classListSection = vm.getSection("__objc_classlist") orelse {
        std.log.err("Cannot read Objective-C classes from executable. Missing section '__objc_classlist'", .{});
        return;
    };

    // The address of the class pointer in the class list
    const listAddr = classListSection.start + id * 8;

    // The address of the class_t
    const classAddr = try vm.readIntLittle(listAddr, u64);
    const classInfo = try objc.readClassInfo(allocator, vm, classAddr);
    std.debug.print("// class_t: 0x{x}\n", .{classInfo.class_t});
    std.debug.print("// class_ro_t: 0x{x}\n\n", .{classInfo.class_ro_t});
    const superclass = classInfo.superclass orelse @as([:0]const u8, "NSObject").ptr ;
    std.debug.print("@interface {s} : {s} (0x{x}) {{\n", .{ classInfo.name, superclass, classInfo.superclassId });
    for (classInfo.variables) |variable| {
        const varType = try objc.decodeTypeName(allocator, std.mem.spanZ(variable.varType));
        defer allocator.free(varType);
        std.debug.print("    {s} {s};\n", .{ varType, variable.name });
    }
    std.debug.print("}}\n", .{});

    for (classInfo.methods) |method| {
        if (classInfo.getVar(std.mem.spanZ(method.name)) != null) {
            const setterName = try std.mem.concat(allocator, u8, &.{ "set", std.mem.spanZ(method.name), ":" });
            defer allocator.free(setterName);
            setterName[3] = std.ascii.toUpper(setterName[3]);
            // It is important to know that the exact @property flags are unknown and depend on implementation
            // TODO: maybe detect them?
            if (classInfo.getMethod(setterName)) |setter| {
                std.debug.print("// Getter: 0x{x}\n", .{ method.imp });
                std.debug.print("// Setter: 0x{x}\n", .{ setter.imp });
                std.debug.print("@property(readwrite) {s} {s};\n\n", .{ method.types, method.name });
            } else {
                std.debug.print("// Getter: 0x{x}\n", .{ method.imp });
                std.debug.print("@property(readonly) {s} {s};\n\n", .{ method.types, method.name });
            }
        } else if (!std.mem.startsWith(u8, std.mem.spanZ(method.name), "set")) {
            std.debug.print("// Implementation: 0x{x}\n", .{method.imp});
            std.debug.print("- (TODO){s} {s}\n\n", .{ method.name, method.types });
        }
    }
    std.debug.print("\n@end\n", .{});
}
