const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    b.installArtifact(
        b.addStaticLibrary(.{
            .name = "zmath",
            .root_source_file = .{ .path = "src/main.zig" },
            .target = target,
            .optimize = optimize,
        }),
    );

    const run_main_tests = b.addRunArtifact(
        b.addTest(.{
            .root_source_file = .{ .path = "src/main.zig" },
            .target = target,
            .optimize = optimize,
        }),
    );

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
