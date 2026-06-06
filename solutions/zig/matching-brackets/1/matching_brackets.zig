const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    for (s) |c| {
        switch (c) {
            '{', '[', '(' => try list.append(c),
            '}', ']', ')' => {
                if (list.pop()) |lastOne| {
                    switch (lastOne) {
                        '{' => if (c != '}') return false,
                        '[' => if (c != ']') return false,
                        '(' => if (c != ')') return false,
                        else => unreachable,
                    }
                } else {
                    return false;
                }
            },
            else => continue,
        }
    }

    return list.items.len == 0;
}
