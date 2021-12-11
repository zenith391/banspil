const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const encoding = @embedFile("aarch64-encoding.csv");
    var lines = std.mem.tokenize(u8, encoding, "\n");

    var rows = std.ArrayList([][]const u8).init(allocator);

    var first: bool = true;
    while (lines.next()) |line| {
        var items = std.ArrayList([]const u8).init(allocator);
        var iterator = std.mem.split(u8, line, ",");
        while (iterator.next()) |item| {
            try items.append(item);
        }
        if (!first) {
            try rows.append(items.toOwnedSlice());
        } else {
            first = false;
        }
    }

    const Immediate = struct {
        pos: usize,
        size: usize,
        name: []const u8
    };

    const Instruction = struct {
        opcode: []const u8,
        variant: []const u8,
        specific: []const u8,
        prependage: []const u8,
        fixedBits: u32,
        expectedBits: u32,
        immediates: std.BoundedArray(Immediate, 32)
    };

    var instructions = std.ArrayList(Instruction).init(allocator);
    defer instructions.deinit();
    for (rows.items) |row| {
        const opcode = row[4];
        const prependage = try std.ascii.allocUpperString(allocator, row[5]);
        const specific = row[7];
        const variant = row[8];
        if (opcode.len > 0) {
            var fixedBits: u32 = 0;
            var expectedBits: u32 = 0;
            var i: usize = 0;
            var immediates = std.BoundedArray(Immediate, 32).init(0) catch unreachable;
            var immediate: ?Immediate = null;

            while (i < 32) : (i += 1) {
                fixedBits = fixedBits << 1;
                expectedBits = expectedBits << 1;
                const bit = row[11 + i];
                if (std.mem.eql(u8, bit, "1") or std.mem.eql(u8, bit, "0")) {
                    fixedBits |= 1;
                    if (std.mem.eql(u8, bit, "1")) {
                        expectedBits |= 1;
                    }
                }
                if (immediate) |*imm| {
                    if (bit.len != 0) {
                        if (immediates.len == 0) {
                            immediates.append(imm.*) catch unreachable;
                        } else {
                            immediates.insert(0, imm.*) catch unreachable;
                        }
                        immediate = null;
                    } else {
                        imm.size += 1;
                    }
                }
                if (immediate == null) {
                    if (bit.len >= 2) {
                        immediate = Immediate { .pos = 32-i, .size = 1, .name = bit };
                    }
                }
            }
            if (immediate) |imm| {
                if (immediates.len == 0) {
                    immediates.append(imm) catch unreachable;
                } else {
                    immediates.insert(0, imm) catch unreachable;
                }
            }

            try instructions.append(Instruction {
                .opcode = opcode,
                .prependage = prependage,
                .variant = variant,
                .specific = specific,
                .fixedBits = fixedBits,
                .expectedBits = expectedBits,
                .immediates = immediates
            });
        }
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print(
        \\const std = @import("std");
        \\
        \\pub const Instruction = enum {{
        \\
    , .{});

    for (instructions.items) |instr| {
        try stdout.print("    @\"{s}{s} {s}{s}\",\n", .{instr.prependage, instr.opcode, instr.variant, instr.specific});
    }
    try stdout.print("}};\n", .{});

    try stdout.print(
        \\pub const Encoding = struct {{
        \\    fields: []const EncodingField
        \\}};
        \\
        \\pub const EncodingField = struct {{
        \\    shift: u5,
        \\    mask: u32,
        \\    immType: enum {{ Immediate, Register, RelAddress }} = .Immediate
        \\}};
        \\
        \\
    , .{});

    try stdout.print(
        \\pub const encoding = blk: {{
        \\    @setEvalBranchQuota(10000);
        \\    break :blk std.enums.directEnumArray(Instruction, Encoding, 0, .{{
        \\
    , .{});

    for (instructions.items) |instr| {
        try stdout.print("    .@\"{s}{s} {s}{s}\" = .{{\n", .{instr.prependage, instr.opcode, instr.variant, instr.specific});
        try stdout.print("        .fields = &[_]EncodingField {{\n", .{});
        for (instr.immediates.constSlice()) |imm| {
            var mask: u32 = 0;
            var j: u5 = 0;
            while (j < imm.size) : (j += 1) {
                mask |= @as(u32, 1) << j;
            }
            try stdout.print("            .{{ .shift = {d}, .mask = 0b{b}", .{imm.pos-imm.size, mask});
            if (imm.name[0] == 'R') {
                try stdout.print(", .immType = .Register ", .{});
            } else if (instr.opcode[0] == 'B') { // branch instruction
                try stdout.print(", .immType = .RelAddress ", .{});
            }
            try stdout.print("}},\n", .{});
        }
        try stdout.print("        }}\n", .{});
        try stdout.print("    }},\n", .{});
    }
    try stdout.print("    }});\n}};\n", .{});

    try stdout.print(
        \\
        \\pub fn decode(opcode: u32) Instruction {{
        \\
    , .{});

    for (instructions.items) |instr| {
        try stdout.print("    // {s}{s}{s} ({s})\n", .{instr.prependage, instr.opcode, instr.variant, instr.specific});
        try stdout.print("    if ((opcode & 0b{b:0>32}) == 0b{b:0>32}) {{\n", .{instr.fixedBits, instr.expectedBits});
        try stdout.print("        return Instruction.@\"{s}{s} {s}{s}\";\n", .{instr.prependage, instr.opcode, instr.variant, instr.specific});
        try stdout.print("    }}\n", .{});
    }
    //try stdout.print("    return Instruction {{ .@\"BAD \" = .{{}} }};\n", .{});
    try stdout.print("    return Instruction.@\"BAD \";\n", .{});
    try stdout.print("}}\n", .{});
}
