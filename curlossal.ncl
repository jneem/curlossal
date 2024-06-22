let { Cursor, CursorSet, CursorTheme, Style, color, .. } = import "cursor.ncl" in
let basic_pointer = "M 222.4,174.4 H 129.6 L 64,240 V 16 Z" in
let hourglass = "m 136.16,190.24 h 20.61 L 136.16,240 h 20.61 z" in
{
  name = "Curlossal",
  style = {
    sizes = [64, 80, 96, 112],
    fill_color = color.from_hex "000000d0",
    stroke_width = 6,
    stroke_color = color.from_hex "00eaffff",
  }, 
  cursors = {
      left_ptr = {
        paths = [basic_pointer],
        hot = { x = 64, y = 16 },
      },

      hand1 = {
        paths = [
          "M 63.867936 11.680424 A 4 4 0 0 0 59.867664 15.680697 A 4 4 0 0 0 63.867936 19.680452 A 4 4 0 0 0 64.000228 19.675802 L 64.000228 239.99982 L 129.59984 174.40021 L 222.39986 174.40021 L 66.600586 18.600415 A 4 4 0 0 0 67.867692 15.680697 A 4 4 0 0 0 63.867936 11.680424 z"
        ],
        hot = { x = 64, y = 16 },
      },

      hand2 = {
        paths = [
          basic_pointer,
          "M 112,20 80,16 112,12 Z",
          "M 27.230447,47.112697 52.686292,27.313708 32.887301,52.769551 Z",
        ],
        hot = { x = 64, y = 16 },
      },

      left_ptr_watch = {
        paths = [basic_pointer, hourglass],
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

      top_left_corner = {
        paths = ["M 16,16 V 128 L 48.8,48.8 128,16 Z"],
        hot = { x = 16, y = 16 },
      },

      top_side = {
        paths = ["m128 16 79.196 79.196L128 62.386l-79.196 32.81Z"],
        hot = { x = 128, y = 16 },
      },
    } | CursorSet
} | CursorTheme
