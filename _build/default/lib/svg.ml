(** Converts typed picture data into SVG format. *)

(** Converts a color to its SVG color name. *)
let string_of_color color =
  match color with
  | Picture.Black -> "black"
  | White -> "white"
  | Gray -> "gray"
  | Red -> "red"
  | Orange -> "orange"
  | Yellow -> "yellow"
  | Green -> "green"
  | Blue -> "blue"
  | Purple -> "purple"
  | Pink -> "pink"
  | Brown -> "brown"
  | Navy -> "navy"
  | Teal -> "teal"
  | Gold -> "gold"
  | Cream -> "cream"

(** [render_to_svg picture] renders a picture as an SVG string. A named
    background color is rendered as a canvas-sized rectangle. A [None]
    background is rendered without a background rectangle. *)
let render_to_svg picture =
  let background =
    match picture.Picture.background with
    | None -> ""
    | Some color ->
        Printf.sprintf
          "<rect x=\"0\" y=\"0\" width=\"%g\" height=\"%g\" fill=\"%s\" />"
          picture.width picture.height (string_of_color color)
  in
  Printf.sprintf
    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"%g\" height=\"%g\" \
     viewBox=\"0 0 %g %g\">%s</svg>"
    picture.width picture.height picture.width picture.height background
