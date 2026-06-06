const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    for (s) |c| {
        switch (c) {
            '{', '[', '(' => try list.append(c),
            '}', ']', ')' => {
                const last = list.getLastOrNull();
                if ((last == '[' and c == ']') or
                    (last == '{' and c == '}') or
                    (last == '(' and c == ')'))
                {
                    _ = list.pop();
                    continue;
                }
                return false;
            },
            else => {},
        }
    }

    return list.items.len == 0;
}
