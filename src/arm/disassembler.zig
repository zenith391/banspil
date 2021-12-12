const std = @import("std");
const encoding = @import("encoding.zig");

pub fn getField(tag: encoding.Instruction, opcode: u32, field: usize) u32 {
    const instruction = encoding.encoding[@enumToInt(tag)];
    return (opcode >> instruction.fields[field].shift) & instruction.fields[field].mask;
}

pub fn getAdrpTarget(addr: u64, opcode: u32) u64 {
    const immhi = getField(.@"ADRP ", opcode, 1);
    const immlo = getField(.@"ADRP ", opcode, 2);
    const imm = (immhi << 2 | immlo) << 12; // TODO: signed!!
    const result = (addr + imm) & (~@as(usize, 0xFFF));
    return result;
}

// Mostly made using https://developer.arm.com/documentation/dui0801/k?lang=en
pub fn disassemble(addr: u64, opcode: u32) encoding.Instruction {
    const stdout = std.io.getStdOut().writer();

    const instructionTag = encoding.decode(opcode);
    const name = @tagName(instructionTag);
    const spacePos = std.mem.indexOfScalar(u8, name, ' ') orelse name.len;
    //stdout.print("{s}", .{name[0..spacePos]}) catch {};
    _ = spacePos;
    stdout.print("{s}", .{ name }) catch {};

    const instruction = encoding.encoding[@enumToInt(instructionTag)];

    if (instructionTag == .@"ADRP ") {
        const Rd = getField(instructionTag, opcode, 0);
        const result = getAdrpTarget(addr, opcode);
        stdout.print(" x{d}, 0x{x}", .{ Rd, result }) catch {};
    } else {
        for (instruction.fields) |field| {
            const value = (opcode >> field.shift) & field.mask;
            switch (field.immType) {
                .Register => {
                    switch (value) {
                        30 => stdout.print(" lr,", .{}) catch {}, // link register
                        31 => stdout.print(" sp,", .{}) catch {}, // stack pointer
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
    }

    return instructionTag;
}
