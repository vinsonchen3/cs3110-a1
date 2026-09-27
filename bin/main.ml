(** Handles CLI communication. *)

let () = 
  if Array.length Sys.argv <> 3 then (
    Printf.eprintf "Usage: %s <input.pic> <output.svg>\n" Sys.argv.(0);
    exit 1
  )
  else
    let input_filename = Sys.argv.(1) in 
    let ouptut_filename = Sys.argv.(2) in 

    print_endline ("Input: " ^ input_filename);
    print_endline ("Output: " ^ output_filename)