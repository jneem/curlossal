from svgpathtools import svg2paths2, wsvg
import sys


def outline_file(in_path: str, out_path: str, fill_color: str, stroke_color: str, stroke_width: float):
    paths, attrs, svg_attrs = svg2paths2(in_path)
    paths, attrs = outline(paths, fill_color, stroke_color, stroke_width)
    wsvg(paths, attributes=attrs, svg_attributes=svg_attrs, filename=out_path)


def outline_transform_file(in_path: str, out_path: str, fill_color: str, stroke_color: str, stroke_width: float, transform):
    paths, attrs, svg_attrs = svg2paths2(in_path)
    paths = [transform.path(p) for p in paths]
    paths, attrs = outline(paths, fill_color, stroke_color, stroke_width)
    wsvg(paths, attributes=attrs, svg_attributes=svg_attrs, filename=out_path)


def outline(paths, fill_color: str, stroke_color: str, stroke_width: float):
    outlines = [outline_one(path, stroke_color, stroke_width) for path in paths]
    fills = [fill_one(path, fill_color) for path in paths]

    paths = [p[0] for p in outlines] + [p[0] for p in fills]
    attrs = [a[1] for a in outlines] + [a[1] for a in fills]
    return (paths, attrs)


def outline_one(path, stroke_color: str, stroke_width: float):
    attribs = {
        'stroke': stroke_color,
        'stroke-width': stroke_width,
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
    }
    return (path, attribs)


def fill_one(path, fill_color: str):
    attribs = {
        'fill': fill_color,
        'stroke': 'none',
    }
    return (path, attribs)


if __name__ == '__main__':
    in_path = sys.argv[1]
    out_path = sys.argv[2]
    fill_color = sys.argv[3]
    stroke_color = sys.argv[4]
    width = float(sys.argv[5])
    outline_file(in_path, out_path, fill_color, stroke_color, width)
