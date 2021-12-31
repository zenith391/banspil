const std = @import("std");
const Allocator = std.mem.Allocator;
const VirtualMemory = @import("memory.zig").VirtualMemory;
const encoding = @import("arm/encoding.zig");
const disassembler = @import("arm/disassembler.zig");

pub const ClassInfo = struct {
    name: [*:0]const u8,
    superclass: ?[*:0]const u8,
    superclassId: ?u64,
    class_t: u64,
    class_ro_t: u64,
    methods: []const Method,
    variables: []const Var,
    allocator: Allocator,

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
            const className = std.mem.span(@ptrCast([*:0]const u8, try vm.getPtr(nameAddr)));
            if (std.mem.eql(u8, className, name)) {
                return try readClassInfo(allocator, vm, classAddr);
            }
            i += 1;
        }
        return null;
    }

    pub fn getMethod(self: *const ClassInfo, name: []const u8) ?Method {
        for (self.methods) |method| {
            const methodName = std.mem.span(method.name);
            if (std.mem.eql(u8, methodName, name)) return method;
        }
        return null;
    }

    /// Get the variable with the given name, note that the starting '_' is automatically stripped
    /// from name search.
    pub fn getVar(self: *const ClassInfo, name: []const u8) ?Var {
        for (self.variables) |variable| {
            const varName = std.mem.span(variable.name);
            if (std.mem.eql(u8, varName[1..], name)) return variable;
        }
        return null;
    }

    pub fn deinit(self: *const ClassInfo) void {
        self.allocator.free(self.variables);
        self.allocator.free(self.methods);
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
        .allocator = allocator,
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
                try writer.print("id", .{});
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

const RegisterContent = union(enum) {
    Undefined: void,
    Argument: u5,
    Register: u5,
    Value: u64,
    /// The value stored in at memory address in payload
    ValueAt: struct {
        ptr: *RegisterContent,
        /// Load size in bytes
        size: u4,
        vm: *const VirtualMemory
    },
    Addition: struct { lhs: *RegisterContent, rhs: *RegisterContent },
    Or: struct { lhs: *RegisterContent, rhs: *RegisterContent },

    pub fn add(allocator: Allocator, a: RegisterContent, b: RegisterContent) !RegisterContent {
        const lhs = try allocator.create(RegisterContent);
        lhs.* = a;
        const rhs = try allocator.create(RegisterContent);
        rhs.* = b;

        return (RegisterContent { .Addition = .{ .lhs = lhs, .rhs = rhs } }).simplify(null);
    }

    pub fn binaryOr(allocator: Allocator, a: RegisterContent, b: RegisterContent) !RegisterContent {
        const lhs = try allocator.create(RegisterContent);
        lhs.* = a;
        const rhs = try allocator.create(RegisterContent);
        rhs.* = b;

        return (RegisterContent { .Or = .{ .lhs = lhs, .rhs = rhs } }).simplify(null);
    }

    pub fn deref(self: RegisterContent, allocator: Allocator, vm: *const VirtualMemory, size: u4) !RegisterContent {
        const at = try allocator.create(RegisterContent);
        at.* = self;
        return (RegisterContent { .ValueAt = .{ .ptr = at, .size = size, .vm = vm }}).simplify(vm);
    }

    pub fn simplify(self: RegisterContent, vm: ?*const VirtualMemory) RegisterContent {
        switch (self) {
            .Addition => |add| {
                add.lhs.* = add.lhs.simplify(vm);
                add.rhs.* = add.rhs.simplify(vm);
                if (add.lhs.* == .Value and add.rhs.* == .Value) {
                    return RegisterContent { .Value = add.lhs.*.Value + add.rhs.*.Value };
                }
            },
            .Or => |bor| {
                _ = bor;
                // TODO: simplify
            },
            .ValueAt => |at| {
                switch (at.ptr.*) {
                    .Value => |value| {
                        if (vm != null) {
                            var isReadOnly = true;
                            if (vm.?.getSectionAt(value)) |section| {
                                if (std.mem.eql(u8, section.name, "__got")) {
                                    isReadOnly = false;
                                }
                            }
                            if (isReadOnly) {
                                var val: u64 = 0;
                                var bytes: u6 = 0;
                                while (bytes < at.size) : (bytes += 1) {
                                    const byte = vm.?.readByte(value + bytes) catch return self;
                                    val = val | (@as(u64, byte) << bytes * 8);
                                }
                                return RegisterContent { .Value = val };
                            }
                        }
                    },
                    else => {}
                }
            },
            else => {} // TODO
        }
        return self;
    }

    pub fn format(value: RegisterContent, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) @TypeOf(writer).Error!void {
        _ = fmt;
        switch (value) {
            .Undefined => try writer.writeAll("undef"),
            .Argument => |arg| try writer.print("arg{d}", .{ arg }),
            .Register => |reg| try writer.print("x{d}", .{ reg }), // TODO: make it more evident that it's the original value
            .Value => |val| try writer.print("0x{x}", .{ val }),
            .ValueAt => |at| {
                // TODO: make it correspond to ivar if it is one
                try writer.writeAll("[");
                try RegisterContent.format(at.ptr.*, "", options, writer);
                try writer.writeAll("]");
                try writer.print(":{d}", .{ @as(u7, at.size) * 8 });
                switch (at.ptr.*) {
                    .Value => |addr| {
                        if (at.vm.getSymbolAt(addr)) |symbol| {
                            try writer.print(" ({s})", .{ symbol.name });
                        }
                    },
                    else => {}
                }
            },
            .Addition => |add| {
                try RegisterContent.format(add.lhs.*, "", options, writer);
                try writer.writeAll(" + ");
                try RegisterContent.format(add.rhs.*, "", options, writer);
            },
            .Or => |bor| {
                try RegisterContent.format(bor.lhs.*, "", options, writer);
                try writer.writeAll(" | ");
                try RegisterContent.format(bor.rhs.*, "", options, writer);
            }
        }
    }
};

pub fn decompile(child_allocator: Allocator, original_start: u64, vm: *const VirtualMemory, org_opcodes: [*]const u32) !void {
    var arena = std.heap.ArenaAllocator.init(child_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // const stdout = std.io.getStdOut().writer();
    var registers: [32]RegisterContent = [1]RegisterContent { .Undefined } ** 32;
    {
        var i: u5 = 0;
        while (i < 7) : (i += 1) {
            registers[i] = .{ .Argument = i };
        }
        while (i < 31) : (i += 1) {
            registers[i] = .{ .Register = i };
        }
        registers[31] = .{ .Register = 31 };
    }

    var i: usize = 0;
    var start = original_start;
    var opcodes = org_opcodes;
    while (true) : (i += 1) {
        const addr = start + i * 4;
        const opcode = try vm.readIntLittle(addr, u32);

        const instructionTag = encoding.decode(opcode);
        switch (instructionTag) {
            .@"ADRP " => {
                const Rd = disassembler.getField(instructionTag, opcode, 0);
                const target = disassembler.getAdrpTarget(addr, opcode);
                registers[Rd] = .{ .Value = target };
                //std.debug.print("x{d} <- 0x{x}\n", .{ Rd, target });
            },
            .@"ADD X" => {
                const Rd = disassembler.getField(instructionTag, opcode, 0);
                const Rm = disassembler.getField(instructionTag, opcode, 1);
                const Rn = disassembler.getField(instructionTag, opcode, 2);
                registers[Rd] = try RegisterContent.add(allocator, registers[Rm], registers[Rn]);
                std.debug.print("x{d} <- x{d} + x{d} = {}\n", .{ Rd, Rm, Rn, registers[Rd] });
            },
            .@"ADD Ximm" => {
                const Rd = disassembler.getField(instructionTag, opcode, 0);
                const Rn = disassembler.getField(instructionTag, opcode, 1);
                const imm = disassembler.getField(instructionTag, opcode, 2);
                registers[Rd] = try RegisterContent.add(allocator, registers[Rn], .{ .Value = imm });
                std.debug.print("x{d} <- x{d} + {d} = {}\n", .{ Rd, Rn, imm, registers[Rd] });
            },
            .@"STP Xpre" => {
                const Rt = disassembler.getField(instructionTag, opcode, 0);
                const Rn = disassembler.getField(instructionTag, opcode, 1);
                const Rt2 = disassembler.getField(instructionTag, opcode, 2);
                const imm = disassembler.getField(instructionTag, opcode, 3);
                std.debug.print("[x{d}:128] + {} = (x{d} << 64) | x{d};\n", .{ Rn, imm, Rt, Rt2 });
            },
            .@"ORR X" => {
                const Rd = disassembler.getField(instructionTag, opcode, 0);
                const Rn = disassembler.getField(instructionTag, opcode, 1);
                const Rm = disassembler.getField(instructionTag, opcode, 2);
                const shift = disassembler.getField(instructionTag, opcode, 3);
                if (shift != 0) {
                    std.log.warn("ORR X: non-zero shift not yet supported!", .{});
                }
                registers[Rd] = try RegisterContent.binaryOr(allocator, registers[Rn], registers[Rm]);
                std.debug.print("x{d} = {}\n", .{ Rd, registers[Rd] });
            },
            .@"LDRSW imm" => {
                const Rn = disassembler.getField(instructionTag, opcode, 0);
                const Rt = disassembler.getField(instructionTag, opcode, 1);
                const imm = disassembler.getField(instructionTag, opcode, 2) << 2;

                const sourceAddr = try RegisterContent.add(allocator, registers[Rn], .{ .Value = imm });
                // TODO: handle signedness
                registers[Rt] = try sourceAddr.deref(allocator, vm, 2);
                std.debug.print("x{d} <- {}\n", .{ Rt, registers[Rt] });
            },
            // LDR immediate with unsigned offset
            .@"LDR Ximm" => {
                const Rn = disassembler.getField(instructionTag, opcode, 0);
                const Rt = disassembler.getField(instructionTag, opcode, 1);
                const size = @truncate(u2, (opcode >> 30));
                const imm = disassembler.getField(instructionTag, opcode, 2) << size;
                if (size != 0b11) {
                    std.log.warn("LDR Ximm: size 0b{b} not supported!", .{ size });
                }

                const sourceAddr = try RegisterContent.add(allocator, registers[Rn], .{ .Value = imm });
                registers[Rt] = try sourceAddr.deref(allocator, vm, 8);
                std.debug.print("x{d} <- {}\n", .{ Rt, registers[Rt] });
            },
            .@"LDR Xoff" => {
                const Rt = disassembler.getField(instructionTag, opcode, 0);
                const Rm = disassembler.getField(instructionTag, opcode, 1);
                const Rn = disassembler.getField(instructionTag, opcode, 2);

                registers[Rt] = try RegisterContent.deref(
                    try RegisterContent.add(allocator, registers[Rm], registers[Rn]), allocator, vm, 8);

                std.debug.print("x{d} <- {}\n", .{ Rt, registers[Rt] });
            },
            .@"LDR W" => {
                const Rt = disassembler.getField(instructionTag, opcode, 0);
                const imm = @bitCast(i21, @intCast(u21, disassembler.getField(instructionTag, opcode, 1) << 2));
                const target = @bitCast(u64, @intCast(i64, addr) + imm);
                
                registers[Rt] = try RegisterContent.deref(
                    RegisterContent { .Value = target }, allocator, vm, 4);

                std.debug.print("x{d} <- {}\n", .{ Rt, registers[Rt] });
            },
            .@"B " => {
                const imm = @intCast(u28, disassembler.getField(instructionTag, opcode, 0) << 2);
                const target = @bitCast(u64, @intCast(i64, addr) + @bitCast(i28, imm));
                std.debug.print("goto 0x{x}\n", .{ target });

                opcodes = @ptrCast([*]const u32, @alignCast(@alignOf(u32), try vm.getPtr(target)));
                start = target - 4;
                i = 0;
            },
            .@"BR " => {
                const Rn = disassembler.getField(instructionTag, opcode, 0);
                std.debug.print("goto x{d} ({})\n", .{ Rn, registers[Rn] });
                registers[Rn] = registers[Rn].simplify(vm);
                if (registers[Rn] == .Value) {
                    opcodes = @ptrCast([*]const u32, @alignCast(@alignOf(u32), try vm.getPtr(registers[Rn].Value)));
                    start = registers[Rn].Value - 4;
                    i = 0;
                    std.debug.print("jumped, continued to 0x{x}\n", .{ registers[Rn].Value });
                } else {
                    std.log.info("Cannot determine the address to jump to", .{});
                    break;
                }
            },
            .@"RET " => {
                std.debug.print("return x0\n", .{ });
                break;
            },
            .@"BAD " => {
                std.debug.print("Incorrect instruction at 0x{x}\n", .{ addr });
                break;
            },
            else => {
                std.log.err("Unimplemented instruction: {}", .{ instructionTag });
                break;
            } // not implemented
        }
    }
}
