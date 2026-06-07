// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2026 Wakana Kisarazu <wakanakisarazu.work@gmail.com>

const std = @import("std");
const EnumArray = std.EnumArray;



const REGISTER_COUNT = 10;
const OPERATION_CODE_COUNT = 16;
const MEMORY_MAX_SIZE = 66536;


const Register = enum(u8)
{
    r0  = 0,
    r1  = 1,
    r2  = 2,
    r3  = 3,
    r4  = 4,
    r5  = 5,
    r6  = 6,
    r7  = 7,
    pc,
    cond,
    count,
};

const OperationCode = enum
{
    br,
    add,
    ld,
    st,
    jsr,
    @"and",
    ldr,
    str,
    rti,
    not,
    ldi,
    sti,
    jmp,
    res,
    lea,
    trap,
};

const ConditionFlag = enum(u4)
{
    positive    = 1,
    zero        = 2,
    negative    = 4,
};

const TrapCode = enum(u8)
{
    getc    = 0x20,
    out     = 0x21,
    puts    = 0x22,
    in      = 0x23,
    putsp   = 0x24,
    halt    = 0x25,
};

const MemoryMappedRegister = enum(u16)
{
    kbsr = 0xFE00,
    kbdr = 0xFE02,
};

memory: [MEMORY_MAX_SIZE]u16,
registers: EnumArray(Register, u16),
