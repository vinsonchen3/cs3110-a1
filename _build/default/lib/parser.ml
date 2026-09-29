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

(** [parse_line line_number words] parses a line element. Raises [ParseError] if
    the parameters are malformed. *)
let parse_line line_number words =
  match words with
  | [ "line"; x1_text; y1_text; x2_text; y2_text; color_text; width_text ] ->
      let x1 = parse_float x1_text "line x1" line_number in
      let y1 = parse_float y1_text "line y1" line_number in
      let x2 = parse_float x2_text "line x2" line_number in
      let y2 = parse_float y2_text "line y2" line_number in
      let stroke = parse_color color_text line_number in
      let width = parse_positive_float width_text "line width" line_number in
      Picture.Line { Picture.x1; y1; x2; y2; stroke; width }
  | _ ->
      raise (ParseError ("Invalid line on line " ^ string_of_int line_number))

(** [parse_text line_number words] parses a text element. Raises [ParseError] if
    the parameters are malformed or the text is empty. *)
let parse_text line_number words =
  match words with
  | "text" :: x_text :: y_text :: size_text :: color_text :: contents ->
      if contents = [] then
        raise
          (ParseError
             ("Text contents cannot be empty on line "
            ^ string_of_int line_number))
      else
        let x = parse_float x_text "text x" line_number in
        let y = parse_float y_text "text y" line_number in
        let size = parse_positive_float size_text "text size" line_number in
        let fill = parse_color color_text line_number in
        let contents = String.concat " " contents in
        Picture.Text { Picture.x; y; size; fill; contents }
  | _ ->
      raise (ParseError ("Invalid text on line " ^ string_of_int line_number))

(** [parse_element line_number words] parses the next element. Raises
    [ParseError] if next line isn't element. *)

(** [parse_transform line_number words] parses a transformation header. Raises
    [ParseError] if the transformation is malformed or its parameters are
    invalid. *)
let parse_transform line_number words =
  match words with
  | [ "transform"; "translate"; dx_text; dy_text ] ->
      let dx = parse_float dx_text "translation x" line_number in
      let dy = parse_float dy_text "translation y" line_number in
      Picture.Translate (dx, dy)
  | [ "transform"; "rotate"; degrees_text ] ->
      let degrees = parse_float degrees_text "rotation degrees" line_number in
      Picture.Rotate degrees
  | [ "transform"; "scale"; factor_text ] ->
      let factor =
        parse_positive_float factor_text "scale factor" line_number
      in
      Picture.Scale factor
  | _ ->
      raise
        (ParseError ("Invalid transform on line " ^ string_of_int line_number))

(** [parse_count word line_number] parses a nonnegative integer repeat count. *)
let parse_count word line_number =
  match int_of_string_opt word with
  | None ->
      raise
        (ParseError ("Invalid repeat count on line " ^ string_of_int line_number))
  | Some count when count < 0 ->
      raise
        (ParseError
           ("Repeat count cannot be negative on line "
          ^ string_of_int line_number))
  | Some count -> count

(** [parse_repeat line_number words] parses a repeat header and returns its
    count and transformation. *)
let parse_repeat line_number words =
  match words with
  | [ "repeat"; count; "translate"; dx; dy ] ->
      let count = parse_count count line_number in
      let dx = parse_float dx "translation x" line_number in
      let dy = parse_float dy "translation y" line_number in
      (count, Picture.Translate (dx, dy))
  | [ "repeat"; count; "rotate"; degrees ] ->
      let count = parse_count count line_number in
      let degrees = parse_float degrees "rotation degrees" line_number in
      (count, Picture.Rotate degrees)
  | [ "repeat"; count; "scale"; factor ] ->
      let count = parse_count count line_number in
      let factor = parse_positive_float factor "scale factor" line_number in
      (count, Picture.Scale factor)
  | _ ->
      raise (ParseError ("Invalid repeat on line " ^ string_of_int line_number))

(** [parse_elements lines] recursively parses elements until it reaches an [end]
    line or the end of [lines]. It returns the entries in source order together
    with the unconsumed lines. It raises [Parse_error] if it encounters a
    malformed line.*)
let rec parse_elements lines =
  match lines with
  | [] -> ([], [])
  | (line_number, line) :: rest -> (
      let words = split_words line in
      match words with
      | [ "end" ] -> ([], (line_number, line) :: rest)
      | "end" :: _ ->
          raise
            (ParseError ("Invalid end on line " ^ string_of_int line_number))
      | _ ->
          let element, remaining = parse_element (line_number, line) rest in
          let elements, final_remaining = parse_elements remaining in
          (element :: elements, final_remaining))

(** [parse_element (line_number, line) rest] parses the next picture element and
    returns the parsed elementwith the remaining lines. *)
and parse_element (line_number, line) rest =
  let words = split_words line in
  match words with
  | "circle" :: _ -> (parse_circle line_number words, rest)
  | "rectangle" :: _ -> (parse_rectangle line_number words, rest)
  | "line" :: _ -> (parse_line line_number words, rest)
  | "text" :: _ -> (parse_text line_number words, rest)
  | "transform" :: _ -> parse_transform_section line_number words rest
  | "repeat" :: _ -> parse_repeat_section line_number words rest
  | word :: _ ->
      raise
        (ParseError
           ("Unknown picture element '" ^ word ^ "' on line "
          ^ string_of_int line_number))
  | [] ->
      raise (ParseError ("Empty element on line " ^ string_of_int line_number))

(** [parse_transform_block line_number words rest] parses a transformation and
    its elements until the matching [end]. *)
and parse_transform_section line_number words rest =
  let transform = parse_transform line_number words in
  let elements, remaining = parse_elements rest in
  match remaining with
  | [] ->
      raise
        (ParseError
           ("Transform block on line " ^ string_of_int line_number
          ^ " is missing end"))
  | (end_line_number, end_line) :: after_end ->
      if split_words end_line = [ "end" ] then
        (Picture.Transform (transform, elements), after_end)
      else
        raise
          (ParseError ("Expected end on line " ^ string_of_int end_line_number))

(** [parse_repeat_section line_number words rest] parses a repeat block and its
    elements until the matching [end]. *)
and parse_repeat_section line_number words rest =
  let count, transform = parse_repeat line_number words in
  let elements, remaining = parse_elements rest in
  match remaining with
  | [] ->
      raise
        (ParseError
           ("Repeat block on line " ^ string_of_int line_number
          ^ " is missing end"))
  | (end_line_number, end_line) :: after_end ->
      if split_words end_line = [ "end" ] then
        (Picture.Repeat (count, transform, elements), after_end)
      else
        raise
          (ParseError ("Expected end on line " ^ string_of_int end_line_number))

(** [parse_lines numbered_lines] parses a canvas and then the following
    elements, if there are any. *)
let parse_lines numbered_lines =
  try
    let lines = filter_lines numbered_lines in
    match lines with
    | [] -> Error "Invalid input (only blank lines)"
    | (canvas_line_number, canvas_line) :: element_lines -> (
        let canvas_words = split_words canvas_line in
        let canvas = parse_canvas canvas_line_number canvas_words in
        let elements, remaining = parse_elements element_lines in
        match remaining with
        | [] -> Ok { canvas with elements }
        | (end_line_number, _) :: _ ->
            raise
              (ParseError
                 ("Invalid end on line " ^ string_of_int end_line_number)))
  with ParseError message -> Error message
