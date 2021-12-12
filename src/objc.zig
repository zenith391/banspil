const std = @import("std");
const Allocator = *std.mem.Allocator;
const VirtualMemory = @import("memory.zig").VirtualMemory;
const encoding = @import("arm/encoding.zig");

pub const ClassInfo = struct {
    name: [*:0]const u8,
    superclass: ?[*:0]const u8,
    superclassId: ?u64,
    class_t: u64,
    class_ro_t: u64,
    methods: []const Method,
    variables: []const Var,

    pub fn getMethod(self: *const ClassInfo, name: []const u8) ?Method {
        for (self.methods) |method| {
            const methodName = std.mem.spanZ(method.name);
            if (std.mem.eql(u8, methodName, name)) return method;
        }
        return null;
    }

    /// Get the variable with the given name, note that the starting '_' is automatically stripped
    /// from name search.
    pub fn getVar(self: *const ClassInfo, name: []const u8) ?Var {
        for (self.variables) |variable| {
            const varName = std.mem.spanZ(variable.name);
            if (std.mem.eql(u8, varName[1..], name)) return variable;
        }
        return null;
    }

    pub fn getClassByName(allocator: Allocator, vm: *const VirtualMemory, name: []const u8) !?ClassInfo {
        const classListSection = vm.getSection("__objc_classlist") orelse {
            std.log.err("Cannot read Objective-C classes from executable. Missing section '__objc_classlist'", .{});
            return null;
        };
        var listAddr = classListSection.start;
        var i: usize = 0;

        while (listAddr < classListSection.start + classListSection.size) : (listAddr += 8) {
            const classAddr = try vm.readIntLittle(listAddr, u64);
            const classRoAddr = try vm.readIntLittle(classAddr + 32, u64);
            const nameAddr = try vm.readIntLittle(classRoAddr + 24, u64);
            const className = std.mem.spanZ(@ptrCast([*:0]const u8, try vm.getPtr(nameAddr)));
            if (std.mem.eql(u8, className, name)) {
                return try readClassInfo(allocator, vm, classAddr);
            }
            i += 1;
        }
        return null;
    }
};

pub const Method = struct {
    name: [*:0]const u8,
    types: [*:0]const u8,
    imp: u64
};

pub const Var = struct {
    name: [*:0]const u8,
    varType: [*:0]const u8
};

// Everything was made using https://opensource.apple.com/source/objc4/objc4-532/runtime/objc-runtime-new.h.auto.html
pub fn readClassInfo(allocator: Allocator, vm: *const VirtualMemory, addr: u64) !ClassInfo {
    // The address of the class_rw_t
    const classRoAddr = try vm.readIntLittle(addr + 32, u64);
    const nameAddr = try vm.readIntLittle(classRoAddr + 24, u64);

    const superclassAddr = try vm.readIntLittle(addr + 8, u64);
    const superclassRoAddr = try vm.readIntLittle(superclassAddr + 32, u64);
    const superNameAddr = try vm.readIntLittle(superclassRoAddr + 24, u64);

    const methodListAddr = try vm.readIntLittle(classRoAddr + 32, u64);
    const entsize = try vm.readIntLittle(methodListAddr + 0, u32);
    const count = try vm.readIntLittle(methodListAddr + 4, u32);

    var methods = std.ArrayList(Method).init(allocator);
    var i: usize = 0;
    while (i < count) : (i += 1) {
        const methodAddr = methodListAddr + 8 + i * entsize;
        const methodSelAddr = try vm.readIntLittle(methodAddr, u64);
        const methodSel = @ptrCast([*:0]const u8, try vm.getPtr(methodSelAddr));

        const methodTypesAddr = try vm.readIntLittle(methodAddr + 8, u64);
        const methodTypes = @ptrCast([*:0]const u8, try vm.getPtr(methodTypesAddr));

        const imp = try vm.readIntLittle(methodAddr + 16, u64);
        const method = Method {
            .name = methodSel,
            .types = methodTypes,
            .imp = imp
        };
        try methods.append(method);
    }

    const ivarListAddr = try vm.readIntLittle(classRoAddr + 48, u64);
    const ivarEntsize = try vm.readIntLittle(ivarListAddr + 0, u32);
    const ivarCount = try vm.readIntLittle(ivarListAddr + 4, u32);

    var variables = std.ArrayList(Var).init(allocator);
    i = 0;
    while (i < ivarCount) : (i += 1) {
        const ivarAddr = ivarListAddr + 8 + i * ivarEntsize;
        const ivarNameAddr = try vm.readIntLittle(ivarAddr + 8, u64);
        const ivarName = @ptrCast([*:0]const u8, try vm.getPtr(ivarNameAddr));

        const ivarTypeAddr = try vm.readIntLittle(ivarAddr + 16, u64);
        const ivarType = @ptrCast([*:0]const u8, try vm.getPtr(ivarTypeAddr));

        try variables.append(.{
            .name = ivarName,
            .varType = ivarType
        });
    }

    return ClassInfo {
        .name = @ptrCast([*:0]const u8, try vm.getPtr(nameAddr)),
        .superclass = if (superclassAddr == 0x0) null else
            @ptrCast([*:0]const u8, try vm.getPtr(superNameAddr)),
        .superclassId = if (superclassAddr == 0x0) null else superclassAddr,
        .class_t = addr,
        .class_ro_t = classRoAddr,
        .methods = methods.toOwnedSlice(),
        .variables = variables.toOwnedSlice()
    };
}

const DecodeTypeNameError = error { } || std.mem.Allocator.Error;
// Made using https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
pub fn decodeTypeName(allocator: Allocator, typeName: []const u8) DecodeTypeNameError![]const u8 {
    var string = std.ArrayList(u8).init(allocator);
    const writer = string.writer();

    var typeChar = typeName[0];
    switch (typeChar) {
        'c' => try writer.writeAll("char"),
        's' => try writer.writeAll("short"),
        'i' => try writer.writeAll("int"),
        'l' => try writer.writeAll("long"),
        'q' => try writer.writeAll("long long"),
        'C' => try writer.writeAll("unsigned char"),
        'S' => try writer.writeAll("unsigned short"),
        'I' => try writer.writeAll("unsigned int"),
        'L' => try writer.writeAll("unsigned long"),
        'Q' => try writer.writeAll("unsigned long long"),
        'f' => try writer.writeAll("float"),
        'd' => try writer.writeAll("double"),
        'B' => try writer.writeAll("bool"),
        'v' => try writer.writeAll("void"),
        '*' => try writer.writeAll("char*"),
        '^' => {
            const next = try decodeTypeName(allocator, typeName[1..]);
            defer allocator.free(next);
            try writer.print("{s}*", .{ next });
        },
        '@' => {
            if (std.mem.indexOfScalarPos(u8, typeName, 1, '"')) |startQuote| {
                const endQuote = std.mem.indexOfScalarPos(u8, typeName, startQuote + 1, '"').?;
                try writer.print("{s}", .{ typeName[startQuote+1..endQuote] });
            } else {
                try writer.print("anyobject", .{});
            }
        },
        '#' => @panic("TODO: class"),
        '[' => @panic("TODO: array"),
        '{' => @panic("TODO: structure"),
        '(' => @panic("TODO: union"),
        'b' => @panic("TODO: bitfield"),
        '?' => try writer.writeAll("unknown"),
        else => unreachable
    }

    return string.toOwnedSlice();
}

pub fn decompile(opcodes: []const u32) void {
    const stdout = std.io.getStdOut().writer();

    for (opcodes) |opcode| {
        const instructionTag = encoding.decode(opcode);
        _ = instructionTag;
        _ = stdout;
    }
}
