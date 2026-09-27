(** Converts source lines into typed picture data. *)

exception ParseError of string

let filter_lines numbered_lines =
  numbered_lines
  |> List.map (fun (line_number, line) -> (line_number, String.trim line))
  |> List.filter (fun (_, line) -> line <> "")

let split_words line =
  line |> String.split_on_char ' ' |> List.filter (fun word -> word <> "")

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
        else Some (parse_color background_text line_number)
      in

      { Picture.width; height; background }
  | _ ->
      raise
        (ParseError ("No valid canvas was found on line " ^ string_of_int line_number))

let parse_lines numbered_lines =
  try
    let lines = filter_lines numbered_lines in
    match lines with
    | [] -> Error "Invalid input (only blank lines)"
    | (line_number, line) :: _ ->
        let words = split_words line in
        Ok (parse_canvas line_number words)
  with ParseError message -> Error message
