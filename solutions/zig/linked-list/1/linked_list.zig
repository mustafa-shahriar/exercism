pub fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *@This(), n: *Node) void {
            if (self.len == 0) {
                self.first = n;
                self.last = n;
            } else {
                self.last.?.next = n;
                n.prev = self.last;
                self.last = n;
            }

            self.len += 1;
        }

        pub fn pop(self: *@This()) ?*Node {
            const n = self.last;
            if (self.len == 1) {
                self.first = null;
                self.last = null;
            } else {
                self.last = n.?.prev;
                self.last.?.next = null;
                n.?.prev = null;
            }

            self.len -= 1;
            return n;
        }

        pub fn shift(self: *@This()) ?*Node {
            const n = self.first;
            if (self.len == 1) {
                self.first = null;
                self.last = null;
            } else {
                self.first = n.?.next;
                self.first.?.prev = null;
            }

            self.len -= 1;
            return n;
        }

        pub fn unshift(self: *@This(), n: *Node) void {
            if (self.len == 0) {
                self.push(n);
                return;
            }

            n.next = self.first;
            self.first.?.prev = n;
            self.first = n;
            self.len += 1;
        }

        pub fn delete(self: *@This(), n: *Node) void {
            if (n == self.first) {
                _ = self.shift();
                return;
            }
            if (n == self.last) {
                _ = self.pop();
                return;
            }

            var node = self.first;
            while (node != null and node != n) {
                node = node.?.next;
            }

            if (node != n or node == null) return;

            node.?.prev.?.next = node.?.next;
            node.?.next.?.prev = node.?.prev;
            self.len -= 1;
        }
    };
}
