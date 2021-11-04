open Printf

let file = "test.txt"

let main () =
    (* let ic = open_in file in *)
(*     try *)

(*         lines_to_list [] in *)
(*         (* list = lines_to_list ic; *) *)
(*       (* let line = input_line ic in *) *)
(*       (*     print_endline line; *) *)
(*       (*     flush stdout; *) *)
(*     with e -> *)
(*         close_in_noerr ic; *)
(*         raise e; *)


    let ic = open_in file in
    try 
        let rec lines_to_list l f =
            match input_line ic with
            | line -> lines_to_list (f line :: l)  f
            | exception End_of_file -> close_in ic; List.rev l in

        let rec print_list l =
            match l with
            | [] -> ()
            | hd :: tl -> print_endline hd; print_list tl in

        let lines = lines_to_list [] String.trim in
        print_list lines ;
    with e ->
        close_in_noerr ic;
        raise e

let () = main ()
