const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var set = std.AutoHashMap(u32, void).init(allocator);
    defer set.deinit();

    var total: u64 = 0;

    for (factors) |factor| {
        if (factor == 0) continue;

        var f: u32 = factor;
        while (f < limit) : (f += factor) {
            if (!set.contains(f)) {
                total += f;
                try set.put(f, {});
            }
        }
    }

    return total;
}
