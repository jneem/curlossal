import outline
import cfg
import subprocess
from pathlib import Path
from clickgen.builders import XCursor
from clickgen.core import CursorAlias

SCALE = 0.625

class Builder:
    out_dir = 'out'
    in_dir = 'shapes'
    hot = cfg.HOT
    to_transform = cfg.TRANSFORM
    fill_color = 'black'
    stroke_color = '#00eaff'
    stroke_width = 12

    def outline_svgs(self):
        for (name, hot) in self.hot.items():
            svg_name = self.in_dir + '/' + name + '.svg'
            out_name = self.out_dir + '/' + name + '.svg'
            outline.outline_file(svg_name, out_name, self.fill_color, self.stroke_color, self.stroke_width)

        for (out_name, (in_name, transform)) in self.to_transform.items():
            svg_path = self.in_dir + '/' + in_name + '.svg'
            self.hot[out_name] = transform.hot(self.hot[in_name])
            out_path = self.out_dir + '/' + out_name + '.svg'
            outline.outline_transform_file(svg_path, out_path, self.fill_color, self.stroke_color, self.stroke_width, transform)

    def render_svgs(self):
        for (name, hot) in self.hot.items():
            svg_path = self.out_dir + '/' + name + '.svg'
            png_path = self.out_dir + '/' + name + '.png'
            subprocess.run(["resvg", "-z", str(SCALE), svg_path, png_path])

    def create_xcursors(self):
        for (name, hot) in self.hot.items():
            png_path = self.out_dir + '/' + name + '.png'
            hot = (int(hot[0] * SCALE), int(hot[1] * SCALE))
            print(hot)
            with CursorAlias.from_bitmap(png=[png_path], hotspot=hot) as alias:
                x_cfg = alias.create(sizes=[(int(256 * SCALE), int(256 * SCALE))])
                XCursor.create(alias_file=x_cfg, out_dir=Path(self.out_dir))


b = Builder()
b.outline_svgs()
b.render_svgs()
b.create_xcursors()
