let
  rotate = fun deg c => c & { rotation_degrees = deg }
in
let
  hex_digit: String -> Number = fun s =>
      { "0" = 0, "1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, a = 10, b = 11, c = 12, d = 13, e = 14, f = 15 }
      |> std.record.get s
in
let
  hex: String -> Number = fun s =>
    s |> std.string.characters
      |> std.array.map hex_digit
      |> std.array.fold_left (fun acc x => acc * 16 + x) 0
in
{
  Point = {
    x | Number,
    y | Number,
  },

  Color = {
    r | Number,
    g | Number,
    b | Number,
    a | Number,
  },

  # TODO: add a contract
  color.from_hex: String -> { r: Number, g: Number, b: Number, a: Number } = fun s => {
     r = hex (std.string.substring 0 2 s),
     g = hex (std.string.substring 2 4 s),
     b = hex (std.string.substring 4 6 s),
     a = if (std.string.length s) == 8 then hex (std.string.substring 6 8 s) else 255,
  },

  Cursor = {
    paths
      | Array String
      | doc "A path, in svg format"
      ,

    hot
      | Point
      ,

    rotation_degrees
      | Number
      | default
      = 0
      ,
  },

  CursorTheme = {
    name | String,
    cursors | CursorSet,
    style | Style,
  },

  Style = {
    size | Number,
    fill_color | Color,
    stroke_width | Number,
    stroke_color | Color,
  },

  CursorSet = {
    left_ptr | Cursor,
    pointer | Cursor,
    xterm | Cursor,

    nw-resize | Cursor,
    ne-resize | Cursor | default = rotate 90 nw-resize,
    se-resize | Cursor | default = rotate 180 nw-resize,
    sw-resize | Cursor | default = rotate 270 nw-resize,

    top_left_corner | Cursor | default = nw-resize,
    top_right_corner | Cursor | default = ne-resize,
    bottom_right_corner | Cursor | default = se-resize,
    bottom_left_corner | Cursor | default = sw-resize,

    n-resize | Cursor,
    e-resize | Cursor | default = rotate 90 n-resize,
    s-resize | Cursor | default = rotate 180 n-resize,
    w-resize | Cursor | default = rotate 270 n-resize,

    top_side | Cursor | default = n-resize,
    right_side | Cursor | default = e-resize,
    bottom_side | Cursor | default = s-resize,
    left_side | Cursor | default = w-resize,

    bd_double_arrow | Cursor,
    fd_double_arrow | Cursor | default = rotate 90 bd_double_arrow,

    sb_h_double_arrow | Cursor,
    sb_v_double_arrow | Cursor | default = rotate 90 sb_h_double_arrow,

    # Aliases for bd_double_arrow
    nwse-resize | Cursor | default = bd_double_arrow,
    size_fdiag | Cursor | default = bd_double_arrow,
    
    # Aliases for fd_double_arrow
    nesw-resize | Cursor | default = fd_double_arrow,
    size_bdiag | Cursor | default = fd_double_arrow,  

    # Aliases for sb_h_double_arrow
    split_h | Cursor | default = sb_h_double_arrow,
    h_double_arrow | Cursor | default = sb_h_double_arrow,

    # Aliases for sb_v_double_arrow
    split_v | Cursor | default = sb_v_double_arrow,
    v_double_arrow | Cursor | default = sb_v_double_arrow,

    # Aliases for xterm
    text | Cursor | default = xterm,
    ibeam | Cursor | default = xterm,

    # Aliases for left_ptr
    arrow | Cursor | default = left_ptr,
    "default" | Cursor | default = left_ptr,

    hand2 | Cursor | default = pointer,
  },
}
