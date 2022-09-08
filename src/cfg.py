import math


class Rotate:
    def __init__(self, angle: float):
        self.angle = angle

    def hot(self, point: (float, float)):
        s = math.sin(self.angle * math.pi / 180)
        c = math.cos(self.angle * math.pi / 180)
        p = (point[0] - 128, point[1] - 128)
        q = (c * p[0] - s * p[1], s * p[0] + c * p[1])
        return (q[0] + 128, q[1] + 128)

    def path(self, path):
        return path.rotated(self.angle, origin=(128 + 128j))


class Copy:
    def hot(self, point: (float, float)):
        return point

    def path(self, path):
        return path


HOT = {
    'bd_double_arrow': (128, 128),
    'left_ptr': (64, 16),
    'pointer': (64, 16),
    'sb_h_double_arrow': (128, 128),
    'xterm': (128, 128),
    'nw-resize': (16, 16),
    'n-resize': (128, 16),
}

TRANSFORM = {
    'nwse-resize': ('bd_double_arrow', Copy()),
    'size_fdiag': ('bd_double_arrow', Copy()),
    'fd_double_arrow': ('bd_double_arrow', Rotate(90)),
    'size_bdiag': ('bd_double_arrow', Rotate(90)),
    'nesw-resize': ('bd_double_arrow', Rotate(90)),
    'sb_v_double_arrow': ('sb_h_double_arrow', Rotate(90)),
    'v_double_arrow': ('sb_h_double_arrow', Rotate(90)),
    'double_arrow': ('sb_h_double_arrow', Rotate(90)),
    'split_v': ('sb_h_double_arrow', Rotate(90)),
    'split_h': ('sb_h_double_arrow', Copy()),
    'h_double_arrow': ('sb_h_double_arrow', Copy()),
    'text': ('xterm', Copy()),
    'ibeam': ('xterm', Copy()),
    'arrow': ('left_ptr', Copy()),
    'default': ('left_ptr', Copy()),
    'top_left_corner': ('nw-resize', Copy()),
    'ne-resize': ('nw-resize', Rotate(90)),
    'top_right_corner': ('nw-resize', Rotate(90)),
    'se-resize': ('nw-resize', Rotate(180)),
    'bottom_right_corner': ('nw-resize', Rotate(180)),
    'sw-resize': ('nw-resize', Rotate(270)),
    'bottom_left_corner': ('nw-resize', Rotate(270)),
    'top_side': ('n-resize', Copy()),
    'e-resize': ('n-resize', Rotate(90)),
    'right_side': ('n-resize', Rotate(90)),
    's-resize': ('n-resize', Rotate(180)),
    'bottom_side': ('n-resize', Rotate(180)),
    'w-resize': ('n-resize', Rotate(270)),
    'left_side': ('n-resize', Rotate(270)),
    'hand2': ('pointer', Copy()),
}
