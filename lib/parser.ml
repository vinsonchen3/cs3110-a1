(** Converts source lines into typed picture data. *)

exception ParseError of string

let filter_lines numbered_lines =
  numbered_lines
  |> List.map (fun (line_number, line) -> (line_number, String.trim line))
  |> List.filter (fun (_, line) -> line <> "")

let split_words line =
  line 
  |> String.split_on_char ' ' 
  |> List.filter (fun word -> word <> "")

let parse_color word = 
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
  | _ -> raise (ParseError ("Invalid color: " ^ word))


let parse_canvas line_numer words =
  match words with
  