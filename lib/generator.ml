(** Coordinates the whole pipeline from reading .pic files to writing .svg. *)

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
