const std = @import("std");

const validNumbers: [9][]const u8 = [_][]const u8{
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
};

pub fn main() !void {
    var file = try std.fs.cwd().openFile("src/input.txt", .{});
    defer file.close();

    // Found this on the net:
    // var buffReader = std.io.bufferedReader(file.reader());
    // var inStream = buffReader.reader();

    // But this works too:
    var inStream = file.reader();

    var sum: u64 = 0;
    var buffer: [255]u8 = undefined;
    while (try inStream.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        var firstNumber = findFirstNumber(line);
        var lastNumber = findLastNumber(line);

        const foundFirstAndLast = (firstNumber != null) and (lastNumber != null);
        if (foundFirstAndLast) {
            const combinedNumber = (firstNumber.? * 10) + lastNumber.?;
            sum = sum + combinedNumber;
        }
    }
    std.debug.print("{}\n", .{sum});
}

// Find the first number character ['0'-'9'] in line character string, and return it if it is found.
pub fn findFirstNumber(line: []u8) ?u8 {
    var i: u8 = 0;
    while (i < line.len) {
        const char = line[i];
        var result: ?u8 = switch (char) {
            '1' => 1,
            '2' => 2,
            '3' => 3,
            '4' => 4,
            '5' => 5,
            '6' => 6,
            '7' => 7,
            '8' => 8,
            '9' => 9,
            else => null,
        };

        const foundFirstNumber = (result != null);
        if (foundFirstNumber) {
            return result;
        }

        i += 1;
    }

    return null;
}

// Find the last number character ['0'-'9'] in line character string, and return it if it is found.
pub fn findLastNumber(line: []u8) ?u8 {
    var i: u8 = @as(u8, @intCast(line.len)) - 1;
    while (i >= 0) {
        const char = line[i];
        var result: ?u8 = switch (char) {
            '1' => 1,
            '2' => 2,
            '3' => 3,
            '4' => 4,
            '5' => 5,
            '6' => 6,
            '7' => 7,
            '8' => 8,
            '9' => 9,
            else => null,
        };

        const foundFirstNumber = (result != null);
        if (foundFirstNumber) {
            return result;
        }

        i -= 1;
    }

    return null;
}

// Return null of subString is not in line, return the starting location of subString in line if it is present.
pub fn stringContainSubString(_: []u8, _: []const u8) ?u8 {
    return null;
}
