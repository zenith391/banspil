const std = @import("std");

pub const Symbol = struct {
    name: []const u8
};

pub const Section = struct {
    name: []const u8,
    //symbol: []const Symbol,

    start: u64,
    size: u64,
    mem: []const u8,
};

pub const Segment = struct {
    name: []const u8,
    sections: []const Section,

    start: u64,
    size: u64
};

pub const VirtualMemory = struct {
    allocator: std.mem.Allocator,
    segments: []const Segment,
    symbols: std.AutoHashMap(u64, Symbol),

    const zero: u8 = 0;

    /// Returns a pointer to a constant byte in virtual memory.
    /// If you ptrCast the returned pointer, beware that the resulting pointer will be unsafe as reading across sectors will cause undefined behaviour.
    pub fn getPtr(self: *const VirtualMemory, addr: u64) !*const u8 {
        for (self.segments) |segment| {
            if (addr >= segment.start and addr < segment.start + segment.size) {
                // Search the section containing 'addr'
                for (segment.sections) |section| {
                    if (addr >= section.start and addr < section.start + section.size) {
                        // The address relative to the section start
                        const sectionAddr = addr - section.start;
                        return &section.mem[sectionAddr];
                    }
                }
                // If the address is in the segment but no section contains it, this mean it hasn't been
                // filled by the linker, therefore we return 0 because by default it is zero-filled.
                return &zero;
            }
        }
        return error.Unbound;
    }

    pub fn readByte(self: *const VirtualMemory, addr: u64) !u8 {
        return (try self.getPtr(addr)).*;
    }

    /// Returns the section struct with the corresponding name or null if not found.
    pub fn getSection(self: *const VirtualMemory, name: []const u8) ?Section {
        for (self.segments) |segment| {
            for (segment.sections) |section| {
                if (std.mem.eql(u8, section.name, name)) {
                    return section;
                }
            }
        }
        return null;
    }

    pub fn getSectionAt(self: *const VirtualMemory, addr: u64) ?Section {
        for (self.segments) |segment| {
            if (addr >= segment.start and addr < segment.start + segment.size) {
                for (segment.sections) |section| {
                    if (addr >= section.start and addr < section.start + section.size) {
                        return section;
                    }
                }
                return null;
            }
        }
        return null;
    }

    pub fn getSymbolAt(self: *const VirtualMemory, addr: u64) ?Symbol {
        return self.symbols.get(addr);
    }

    /// Fill the slice from content of the virtual memory, starting from addr.
    pub fn readSlice(self: *const VirtualMemory, addr: u64, slice: []u8) !void {
        var i: usize = 0;
        while (i < slice.len) : (i += 1) {
            slice[i] = try self.readByte(addr + i);
        }
    }

    /// Read a little-endian integer from virtual memory.
    pub fn readIntLittle(self: *const VirtualMemory, addr: u64, comptime T: type) !T {
        var array: [(@typeInfo(T).Int.bits + 7) / 8]u8 = undefined;
        try self.readSlice(addr, &array);
        return std.mem.readIntLittle(T, &array);
    }

    pub fn deinit(self: *VirtualMemory) void {
        for (self.segments) |segment| {
            for (segment.sections) |section| {
                self.allocator.free(section.mem);
                self.allocator.free(section.name);
            }
            self.allocator.free(segment.sections);
            self.allocator.free(segment.name);
        }
        self.allocator.free(self.segments);
        var iterator = self.symbols.valueIterator();
        while (iterator.next()) |symbol| {
            self.allocator.free(symbol.name);
        }
        self.symbols.deinit();
    }


};
