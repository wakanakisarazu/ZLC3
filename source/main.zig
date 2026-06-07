// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2026 Wakana Kisarazu <wakanakisarazu.work@gmail.com>

const std = @import("std");
const Io = std.Io;
const process = std.process;

const Library = @import("Library");
const OOM = Library.OOM;
const ABRT = Library.ABRT;

const Device = @import("Device");



pub fn main(init: process.Init) !void 
{
    const io = init.io;
    const arena = init.arena;
    const allocator = arena.allocator();
    defer arena.deinit();

    const args = init.minimal.args.toSlice(allocator)
    catch |err| switch (err) {
        error.OutOfMemory   => OOM(),
        else                => ABRT(err)
    };

    if (args.len < 2) {
        Library.help();
        process.cleanExit(io);
    }

    const stdio = Library.Stdio.init();
}