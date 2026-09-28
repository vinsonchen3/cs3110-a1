(** Coordinates the whole pipeline from reading .pic files to writing .svg. *)

(** [read_numbered_lines input_filename] reads all lines from [input_filename]
    and returns them paired with their line numbers. Returns [Ok numbered_lines]
    if the file is read successfully, or [Error message] if the file is invalid.
*)
let read_numbered_lines input_filename =
  try
    let lines =
      In_channel.with_open_text input_filename In_channel.input_lines
    in
    let numbered_lines =
      List.mapi (fun index line -> (index + 1, line)) lines
    in
    Ok numbered_lines
  with Sys_error message -> Error message

(** [parse_file numbered_lines] parses [numbered_lines]. Return is based on
    Parser.parse_lines. *)
let parse_file numbered_lines = Parser.parse_lines numbered_lines

let create_svg input_filename output_filename =
  match read_numbered_lines input_filename with
  | Error message -> Error message
  | Ok numbered_lines -> (
      match parse_file numbered_lines with
      | Error message -> Error message
      | Ok picture -> (
          let svg_text = Svg.render_to_svg picture in
          try
            Out_channel.with_open_text output_filename
              (fun channel -> output_string channel svg_text)
              Ok ()
          with Sys_error message ->
            Error ("Couldn't write output file " ^ message)))
