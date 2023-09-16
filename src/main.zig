const std = @import("std");

fn Vector(comptime T: type, comptime N: usize) type {
    return struct {
        const Self = @This();

        data: [N]T,

        pub fn length(self: Self) T {
            var sum: T = 0;
            for (self.data) |v| {
                sum += v * v;
            }
            return std.math.sqrt(sum);
        }

        pub fn normalize(self: Self) Self {
            var len = self.length();
            var newData: [N]T = undefined;
            for (self.data, 0..) |v, i| {
                newData[i] = v / len;
            }
            return Vector(T, N){ .data = newData };
        }
    };
}

pub const Vector2 = Vector(f32, 2);
pub const Vector3 = Vector(f32, 3);

test "Vector2 - length" {
    var v: Vector2 = .{ .data = .{ 3.0, 4.0 } };

    var l = v.length();

    try std.testing.expect(l == 5.0);
}

test "Vector2 - normalize" {
    var v: Vector2 = .{ .data = .{ 3.0, 4.0 } };

    var n = v.normalize();

    try std.testing.expect(n.data[0] == 0.6);
    try std.testing.expect(n.data[1] == 0.8);
}

test "Vector3 - length" {
    var v: Vector3 = .{ .data = .{ 10.0, 0.0, 0.0 } };

    var l = v.length();

    try std.testing.expect(l == 10.0);
}

test "Vector3 - normalize" {
    var v: Vector3 = .{ .data = .{ 10.0, 0.0, 0.0 } };

    var n = v.normalize();

    try std.testing.expect(n.data[0] == 1.0);
    try std.testing.expect(n.data[1] == 0.0);
    try std.testing.expect(n.data[2] == 0.0);
}
