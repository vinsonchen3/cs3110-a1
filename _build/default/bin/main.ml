(** Handles CLI communication. *)

let () =
  if Array.length Sys.argv <> 3 then (
    Printf.eprintf "Usage: %s <input.pic> <output.svg>\n" Sys.argv.(0);
    exit 1)
  else
    let input_filename = Sys.argv.(1) in
    let output_filename = Sys.argv.(2) in
    match A1.Generator.create_svg input_filename output_filename with
    | Ok () -> ()
    | Error message ->
        Printf.eprintf "Error: %s" message;
        exit 1
