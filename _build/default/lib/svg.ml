(** Converts typed picture data into SVG format. *)

(** Converts a color to its SVG color name. *)
let string_of_color color =
  match color with
  | Picture.Black -> "#111111"
  | White -> "#ffffff"
  | Gray -> "#808080"
  | Red -> "#c1121f"
  | Orange -> "#f77f00"
  | Yellow -> "#fcbf49"
  | Green -> "#2a9d8f"
  | Blue -> "#277da1"
  | Purple -> "#7b2cbf"
  | Pink -> "#e76f91"
  | Brown -> "#8d6e63"
  | Navy -> "#091226"
  | Teal -> "#008080"
  | Gold -> "#d9a441"
  | Cream -> "#fff1b0"

(** [string_of_transform transform] converts a transformation to SVG text. *)
let svg_of_transform transform =
  match transform with
  | Picture.Translate (dx, dy) -> Printf.sprintf "translate(%g %g)" dx dy
  | Picture.Rotate degrees -> Printf.sprintf "rotate(%g)" degrees
  | Picture.Scale factor -> Printf.sprintf "scale(%g)" factor

(** [render_element element] converts a picture element to SVG text. *)
let rec render_element element =
  match element with
  | Picture.Circle { c_x; c_y; radius; fill } ->
      Printf.sprintf "<circle cx=\"%g\" cy=\"%g\" r=\"%g\" fill=\"%s\" />" c_x
        c_y radius (string_of_color fill)
  | Picture.Rectangle { x; y; width; height; fill } ->
      Printf.sprintf
        "<rect x=\"%g\" y=\"%g\" width=\"%g\" height=\"%g\" fill=\"%s\" />" x y
        width height (string_of_color fill)
  | Picture.Line { x1; y1; x2; y2; stroke; width } ->
      Printf.sprintf
        "<line x1=\"%g\" y1=\"%g\" x2=\"%g\" y2=\"%g\" stroke=\"%s\" \
         stroke-width=\"%g\" />"
        x1 y1 x2 y2 (string_of_color stroke) width
  | Picture.Text { x; y; size; fill; contents } ->
      Printf.sprintf
        "<text x=\"%g\" y=\"%g\" font-size=\"%g\" fill=\"%s\" \
         text-anchor=\"middle\">%s</text>"
        x y size (string_of_color fill) contents
  | Picture.Transform (transform, elements) ->
      Printf.sprintf "<g transform=\"%s\">%s</g>"
        (svg_of_transform transform)
        (render_elements elements)

(** [render_elements elements] renders all elements in order. *)
and render_elements elements =
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
