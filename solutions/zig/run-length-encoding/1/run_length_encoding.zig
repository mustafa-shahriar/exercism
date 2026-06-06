const std = @import("std");

fn intLen(int: usize) usize {
    var len: usize = 0;
    var n: usize = int;
    while (n > 0) : (n /= 10) {
        len += 1;
    }
    return len;
}

fn insertIntoBuffer(count: usize, pos: usize, buffer: []u8, char: u8) usize {
    if (count == 1) {
        buffer[pos] = char;
        return pos + 1;
    }

    const newPos: usize = intLen(count) + pos;
    var i: usize = newPos;
    var n: usize = count;
    while (i > pos) {
        i -= 1;
        const c: u8 = @intCast(n % 10);
        n /= 10;
        buffer[i] = c + '0';
    }

    buffer[newPos] = char;
    return newPos + 1;
}

pub fn encode(buffer: []u8, string: []const u8) []u8 {
    if (string.len == 0) return buffer[0..0];

    var pos: usize = 0;
    var count: usize = 1;
    var currentChar: u8 = string[0];
    for (string[1..]) |char| {
        if (currentChar == char) {
            count += 1;
            continue;
        }
        pos = insertIntoBuffer(count, pos, buffer, currentChar);
        currentChar = char;
        count = 1;
    }
    pos = insertIntoBuffer(count, pos, buffer, currentChar);
    return buffer[0..pos];
}

pub fn decode(buffer: []u8, string: []const u8) []u8 {
    var pos: usize = 0;
    var i: usize = 0;
    while (i < string.len) : (i += 1) {
        var count: usize = 0;

        while (string[i] >= '0' and string[i] <= '9') : (i += 1) {
            count = (count * 10) + (string[i] - '0');
        }

        const limit = if (count == 0) pos + 1 else pos + count;
        while (pos < limit) : (pos += 1) {
            buffer[pos] = string[i];
        }
    }

    return buffer[0..pos];
}
