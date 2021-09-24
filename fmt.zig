const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const sep = std.fs.path.sep_str;

const src_files = [_][]const u8 {
    // "src/fmt.cc",
    "src/format.cc",
    // "src/os.cc"
};

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub fn includeDir() []const u8 {
    return root();
}

pub fn link(step: *LibExeObjStep) void {
    step.addIncludeDir(root() ++ sep ++ "include");
    step.linkLibCpp();

    inline for (src_files) |file| {
        step.addCSourceFile(root() ++ sep ++ file, &.{"-std=c++20"});
    }
}
