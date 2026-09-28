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
  | "black" -> Some Picture.Black
  | "white" -> Some White
  | "gray" -> Some Gray
  | "red" -> Some Red
  | "orange" -> Some Orange
  | "yellow" -> Some Yellow
  | "green" -> Some Green
  | "blue" -> Some Blue
  | "purple" -> Some Purple
  | "pink" -> Some Pink
  | "brown" -> Some Brown
  | "navy" -> Some Navy
  | "teal" -> Some Teal
  | "gold" -> Some Gold
  | "cream" -> Some Cream
  | _ ->
      raise
        (ParseError
           ("Invalid color: " ^ word ^ " on line " ^ string_of_int line_number))

(** [parse_canvas line_number words] parses [words] for canvases and returns the
    corresponding [Picture.picture]. Raises [ParseError] if the declaration is
    invalid. *)
let parse_canvas line_number words =
  match words with
  | [ "canvas"; width_text; height_text; background_text ] ->
      let width =
        match float_of_string_opt width_text with
        | Some num -> num
        | None ->
            raise
              (ParseError ("Invalid width on line " ^ string_of_int line_number))
      in

      let height =
        match float_of_string_opt height_text with
        | Some num -> num
        | None ->
            raise
              (ParseError ("Invalid height on line " ^ string_of_int line_number))
      in

      if width <= 0.0 then
        raise
          (ParseError
             ("Canvas width must be positive on line "
            ^ string_of_int line_number));

      if height <= 0.0 then
        raise
          (ParseError
             ("Canvas height must be positive on line "
            ^ string_of_int line_number));

      let background =
        if background_text = "none" then None
        else parse_color background_text line_number
      in

      { Picture.width; height; background }
  | _ ->
      raise
        (ParseError
           ("No valid canvas was found on line " ^ string_of_int line_number))

(** [parse_lines numbered_lines] parses the first non-blank line in
    [numbered_lines] as a canvas declaration. Returns [Ok picture] if parsing
    succeeds, or [Error message] if the input is all blank. *)
let parse_lines numbered_lines =
  try
    let lines = filter_lines numbered_lines in
    match lines with
    | [] -> Error "Invalid input (only blank lines)"
    | (line_number, line) :: _ ->
        let words = split_words line in
        Ok (parse_canvas line_number words)
  with ParseError message -> Error message
