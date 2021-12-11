const std = @import("std");
const encoding = @import("encoding.zig");

// Mostly made using https://developer.arm.com/documentation/dui0801/k?lang=en
pub fn disassemble(addr: u64, opcode: u32) encoding.Instruction {
    _ = addr;
    const stdout = std.io.getStdOut().writer();

    const instructionTag = encoding.decode(opcode);
    const name = @tagName(instructionTag);
    const spacePos = std.mem.indexOfScalar(u8, name, ' ') orelse name.len;
    stdout.print("{s}", .{name[0..spacePos]}) catch {};

    const instruction = encoding.encoding[@enumToInt(instructionTag)];

    for (instruction.fields) |field| {
        const value = (opcode >> field.shift) & field.mask;
        switch (field.immType) {
            .Register => {
                switch (value) {
                    30 => stdout.print(" lr,", .{}) catch {},
                    31 => stdout.print(" sp,", .{}) catch {},
                    else => stdout.print(" x{d},", .{ value }) catch {}
                }
            },
            .RelAddress => {
                stdout.print(" 0x{x}", .{ addr + value + 3 }) catch {};
            },
            .Immediate => {
                stdout.print(" #{d} (#0x{0x}),", .{ value }) catch {};
            }
        }
    }

    return instructionTag;
}
