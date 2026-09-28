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

(** [render_element element] converts a picture element to SVG text. *)
let render_element element =
  match element with
  | Picture.Circle { c_x; c_y; radius; fill } ->
      Printf.sprintf "<circle cx=\"%g\" cy=\"%g\" r=\"%g\" fill=\"%s\" />" c_x
        c_y radius (string_of_color fill)
  | Picture.Rectangle { x; y; width; height; fill } ->
      Printf.sprintf
        "<rect x=\"%g\" y=\"%g\" width=\"%g\" height=\"%g\" fill=\"%s\" />" x y
        width height (string_of_color fill)

(** [render_elements elements] renders all elements in order. *)
let render_elements elements =
  let rendered = List.map render_element elements in
  String.concat "" rendered

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
  let elements = render_elements picture.elements in

  Printf.sprintf
    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"%g\" height=\"%g\" \
     viewBox=\"0 0 %g %g\">%s %s</svg>"
    picture.width picture.height picture.width picture.height background
    elements
