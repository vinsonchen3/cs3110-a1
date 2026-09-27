(** Handles CLI communication. *)

let () =
  if Array.length Sys.argv <> 3 then (
    Printf.eprintf "Usage: %s <input.pic> <output.svg>\n" Sys.argv.(0);
    exit 1)
  else
    let input_filename = Sys.argv.(1) in
    (* let output_filename = Sys.argv.(2) in *)

    (* print_endline ("Input: " ^ input_filename); print_endline ("Output: " ^
       output_filename); *)
    match A1.Generator.read_numbered_lines input_filename with
    | Ok numbered_lines -> (
        (* List.iter (fun (line_number, line) -> Printf.printf "%d: %s\n"
           line_number line) numbered_lines *)
        match A1.Generator.parse_file numbered_lines with
        | Ok picture -> print_endline "Successful parsing."
        | Error message ->
            Printf.eprintf "Error: %s\n" message;
            exit 1)
    | Error message ->
        Printf.eprintf "Error: %s\n" message;
        exit 1
