// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2026 Wakana Kisarazu <wakanakisarazu.work@gmail.com>

const std = @import("std");
const debug = std.debug;
const mem = std.mem;
const Io = std.Io;



/// 128KB of heap memory for general use.
const HEAP_MEMORY_SIZE = 1024 * 128;
/// 4KB of memory for standard output.
const STDOUT_MEMORY_SIZE = 1024 * 4;
/// 4KB of memory for standard input.
const STDIN_MEMORY_SIZE = 1024 * 4;

pub inline fn OOM() noreturn { @panic("Aborted (OutOfMemory)"); }
pub noinline fn ABRT(comptime ERR: anyerror) noreturn { @panic("Aborted (" ++ @errorName(ERR) ++ ")"); }


pub inline fn help() void
{
    debug.print(
        \\ zlc3 [EXECUTABLE]
    , .{});
}

pub const Buffer = struct
{
    heap: [HEAP_MEMORY_SIZE]u8,
    stdout: [STDOUT_MEMORY_SIZE]u8,
    stdin: [STDIN_MEMORY_SIZE]u8,

    pub fn init(allocator: mem.Allocator) @This() {
        return .{
            .heap = allocator.alloc(u8, HEAP_MEMORY_SIZE) catch OOM(),
            .stdout = allocator.alloc(u8, STDOUT_MEMORY_SIZE) catch OOM(),
            .stdin = allocator.alloc(u8, STDIN_MEMORY_SIZE) catch OOM(),
        };
    }
};

pub const Stdio = struct 
{
    out:    Io.File,
    err:    Io.File,
    in:     Io.File,

    pub fn init() @This() {
        return .{ 
            .out = Io.File.stdout(),
            .err = Io.File.stderr(),
            .in = Io.File.stdin(),
        };
    }
};