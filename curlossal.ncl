let { Cursor, CursorSet, CursorTheme, Style, color, .. } = import "cursor.ncl" in
{
  name = "Curlossal",
  style = {
    size = 128,
    fill_color = color.from_hex "000000d0",
    stroke_width = 6,
    stroke_color = color.from_hex "00eaffff",
  }, 
  cursors = {
      left_ptr = {
        paths = ["M 222.4,174.4 H 129.6 L 64,240 V 16 Z"],
        hot = { x = 64, y = 16 },
      },

      pointer = {
        paths = [
          "M 222.4,174.4 H 129.6 L 64,240 V 16 Z",
          "M 125.82,32.56 64,16 h 64 z",
          "M 31.99635,71.423026 64,16 18.745169,61.25483 Z"
        ],
        hot = { x = 64, y = 16 },
      },

      bd_double_arrow = {
        paths = ["M 116.68629,207.19596 150.62742,173.25484 128,128 82.745164,105.37258 48.804039,139.31371 48.80404,48.804039 H 139.3137 L 105.37258,82.745166 128,128 l 45.25483,22.62742 33.94113,-33.94112 v 90.50966 z"],
        hot = { x = 128, y = 128 },
      },

      sb_h_double_arrow = {
        paths = ["m 176,192 v -48 l -48,-16 -48,16 v 48 L 16,128 80,64 v 48 l 48,16 48,-16 V 64 l 64,64 z"],
        hot = { x = 128, y = 128 },
      },

      xterm = {
        paths = ["M 144,63.009766 192,48 V 16 L 128,33.150391 64,16 V 48 L 112,63.009766 128,128 112,192.99023 64,208 v 32 L 128,222.84961 192,240 V 208 L 144,192.99023 128,128 Z"],
        hot = { x = 128, y = 128 },
      },

      nw-resize = {
        paths = ["M 16,16 V 128 L 48.8,48.8 128,16 Z"],
        hot = { x = 16, y = 16 },
      },

      n-resize = {
        paths = ["m128 16 79.196 79.196L128 62.386l-79.196 32.81Z"],
        hot = { x = 128, y = 16 },
      },
    } | CursorSet
} | CursorTheme
