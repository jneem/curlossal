from svgpathtools import svg2paths2
import svgwrite
import svgwrite.path
import cfg
import sys


def outline_file(
        in_path: str,
        out_path: str,
        fill_color: str,
        fill_opacity: float,
        stroke_color: str,
        stroke_width: float):
    return outline_transform_file(
        in_path,
        out_path,
        fill_color,
        fill_opacity,
        stroke_color,
        stroke_width,
        cfg.Copy())


def outline_transform_file(
        in_path: str,
        out_path: str,
        fill_color: str,
        fill_opacity: float,
        stroke_color: str,
        stroke_width: float,
        transform):
    paths, _attrs, svg_attrs = svg2paths2(in_path)
    svg_attrs.pop('xmlns:svg', None)
    print(svg_attrs)
    dwg = svgwrite.Drawing(out_path, **svg_attrs)

    # blur_filter = dwg.defs.add(dwg.filter())
    # blur_filter.feGaussianBlur(in_='SourceGraphic', stdDeviation=2)

    for p in paths:
        d = transform.path(p).d()
        mask = mask_complement(d)

        dwg.defs.add(mask)

        stroke = svgwrite.path.Path(
            d,
            stroke=stroke_color, stroke_width=stroke_width,
            stroke_linecap='round', stroke_linejoin='round',
            fill='none',
            # filter=blur_filter.get_funciri(),
            mask=mask.get_funciri())

        fill = svgwrite.path.Path(
            d,
            fill=fill_color,
            fill_opacity=str(fill_opacity),
            stroke='none'
        )
        dwg.add(stroke)
        dwg.add(fill)

    dwg.save()


def mask_complement(d: str):
    m = svgwrite.masking.Mask()
    m.add(svgwrite.shapes.Rect((0, 0), (256, 256), fill='white'))
    m.add(svgwrite.path.Path(d, fill='black'))
    return m


if __name__ == '__main__':
    in_path = sys.argv[1]
    out_path = sys.argv[2]
    fill_color = sys.argv[3]
    fill_opacity = float(sys.argv[4])
    stroke_color = sys.argv[5]
    width = float(sys.argv[6])
    outline_file(in_path, out_path, fill_color, fill_opacity, stroke_color, width)
