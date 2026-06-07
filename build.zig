// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2026 Wakana Kisarazu <wakanakisarazu.work@gmail.com>

const std = @import("std");
const Build = std.Build;



pub fn build(b: *Build) void
{
    const optimizeMode = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .Debug,
    });

    const resolvedTarget = b.standardTargetOptions(.{
        .default_target = .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .gnu }
    });

    const libraryModule = b.addModule("Library", .{
        .optimize = optimizeMode,
        .target = resolvedTarget,
        .root_source_file = b.path("source/Library.zig")
    });

    const deviceModule = b.addModule("Device", .{
        .optimize = optimizeMode,
        .target = resolvedTarget,
        .root_source_file = b.path("source/Device.zig")
    });

    const executable = b.addExecutable(.{
        .name = "zlc3",
        .linkage = .dynamic,
        .root_module = b.createModule(.{
            .optimize = optimizeMode,
            .target = resolvedTarget,
            .link_libc = true,
            .root_source_file = b.path("source/main.zig")
        })
    });

    executable.root_module.addImport("Library", libraryModule);
    executable.root_module.addImport("Device", deviceModule);

    b.installArtifact(executable);
}