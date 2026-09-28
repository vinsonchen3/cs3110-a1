(** Converts source lines into typed picture data. *)

exception ParseError of string

(** [filter_lines numbered_lines] removes blank lines from [numbered_lines] and
    trims whitespace from each remaining line. *)
let filter_lines numbered_lines =
  numbered_lines
  |> List.map (fun (line_number, line) -> (line_number, String.trim line))
  |> List.filter (fun (_, line) -> line <> "")

(** [split_words line] splits [line] into a list of words separated by spaces,
    omitting empty strings. *)
let split_words line =
  line |> String.split_on_char ' ' |> List.filter (fun word -> word <> "")

(** [parse_color word line_number] converts [word] to its corresponding
    [Picture.color] option. Raises [ParseError] if [word] is not a valid color.
*)
let parse_color word line_number =
  match word with
  | "black" -> Picture.Black
  | "white" -> White
  | "gray" -> Gray
  | "red" -> Red
  | "orange" -> Orange
  | "yellow" -> Yellow
  | "green" -> Green
  | "blue" -> Blue
  | "purple" -> Purple
  | "pink" -> Pink
  | "brown" -> Brown
  | "navy" -> Navy
  | "teal" -> Teal
  | "gold" -> Gold
  | "cream" -> Cream
  | _ ->
      raise
        (ParseError
           ("Invalid color: " ^ word ^ " on line " ^ string_of_int line_number))

(** [parse_float word name line_number] converts [word] to a float. Raises
    [ParseError] with a helpful message if conversion fails. *)
let parse_float word name line_number =
  match float_of_string_opt word with
  | Some num -> num
  | None ->
      raise
        (ParseError ("Invalid " ^ name ^ " on line " ^ string_of_int line_number))

(** [parse_positive_float word name line_number] parses [word] as a positive
    floating-point number. Raises [ParseError] if the value is not positive. *)
let parse_positive_float word name line_number =
  let num = parse_float word name line_number in
  if num <= 0.0 then
    raise
      (ParseError
         (name ^ " must be positive on line " ^ string_of_int line_number))
  else num

(** [parse_canvas line_number words] parses [words] for canvases and returns the
    corresponding [Picture.picture]. Raises [ParseError] if the declaration is
    invalid. *)
let parse_canvas line_number words =
  match words with
  | [ "canvas"; width_text; height_text; background_text ] ->
      let width = parse_positive_float width_text "canvas width" line_number in

      let height =
        parse_positive_float height_text "canvas height" line_number
      in

      let background =
        if background_text = "none" then None
        else Some (parse_color background_text line_number)
      in

      { Picture.width; height; background; elements = [] }
  | _ ->
      raise
        (ParseError
           ("No valid canvas was found on line " ^ string_of_int line_number))

(** [parse_circle line_number words] parses a circle. Raises [ParseError] if the
    parameters are malformed. *)
let parse_circle line_number words =
  match words with
  | [ "circle"; center_x_text; center_y_text; radius_text; color_text ] ->
      let c_x = parse_float center_x_text "circle center-x" line_number in
      let c_y = parse_float center_y_text "circle center-y" line_number in
      let radius =
        parse_positive_float radius_text "Circle radius" line_number
      in
      let fill = parse_color color_text line_number in

      Picture.Circle { Picture.c_x; c_y; radius; fill }
  | _ ->
      raise (ParseError ("Invalid circle on line " ^ string_of_int line_number))

(** [parse_rectangle line_number words] parses a rectangle. Raises [ParseError]
    if the parameters are malformed. *)
let parse_rectangle line_number words =
  match words with
  | [ "rectangle"; x_text; y_text; width_text; height_text; color_text ] ->
      let x = parse_float x_text "rectangle x" line_number in
      let y = parse_float y_text "rectangle y" line_number in
      let width =
        parse_positive_float width_text "Rectangle width" line_number
      in
      let height =
        parse_positive_float height_text "Rectangle height" line_number
      in
      let fill = parse_color color_text line_number in

      Picture.Rectangle { Picture.x; y; width; height; fill }
  | _ ->
      raise
        (ParseError ("Invalid rectangle on line " ^ string_of_int line_number))

(** [parse_element line_number words] parses the next element. Raises
    [ParseError] if next line isn't element. *)
let parse_element line_number words =
  match words with
  | "circle" :: _ -> parse_circle line_number words
  | "rectangle" :: _ -> parse_rectangle line_number words
  | word :: _ ->
      raise
        (ParseError
           ("Unknown picture element '" ^ word ^ "' on line "
          ^ string_of_int line_number))
  | [] ->
      raise
        (ParseError
           ("Empty picture element on line " ^ string_of_int line_number))

(** [parse_lines numbered_lines] parses a canvas and then the following
    elements, if there are any. *)
let parse_lines numbered_lines =
  try
    let lines = filter_lines numbered_lines in
    match lines with
    | [] -> Error "Invalid input (only blank lines)"
    | (canvas_line_number, canvas_line) :: element_lines ->
        let canvas_words = split_words canvas_line in
        let canvas = parse_canvas canvas_line_number canvas_words in
        let elements =
          List.map
            (fun (line_number, line) ->
              parse_element line_number (split_words line))
            element_lines
        in
        Ok { canvas with elements }
  with ParseError message -> Error message
