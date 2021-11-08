open Printf

let file = "test.txt"

let () =
    let ic = open_in file in
    try 
        let rec lines_to_list l f =
            match input_line ic with
            | line -> lines_to_list ((f line) :: l) f
            | exception End_of_file -> close_in ic; List.rev l in

        let minor_words = ["the"; "and"] in
        
        (*
            list of tuple with (index, non-blank line)
            `index` is associated with the order in which the line has appeared in the file
            and the `non-blank line` is the trimmed line
        *)
        let lines = List.mapi
            (fun i a -> (i,a))
            (List.filter
                (fun l ->  l <> "")
                (lines_to_list [] String.trim)) in

        (*
            list of tuple with (index, list of strings)
            `index` is as above
            `list of strings` is composed by the words of each line without ws
        *)
        let words =
            List.map (fun tuple -> 
                ((fst tuple), (String.split_on_char ' ' (snd tuple)))) lines in
        (* 
            list of tuple (index, list of strings)
            `index` is as above
            `list of strings` is the same as above except that the minor words are filtered and sorted
        *)
        let filtered_words =
            List.map (fun tuple ->
                (fst tuple,
                    List.sort (fun s1 s2 -> String.compare s1 s2) 
                    (List.filter
                        (fun l ->
                            not (List.exists
                                    (fun minor_word ->
                                        String.lowercase_ascii minor_word = String.lowercase_ascii l)
                                    minor_words)
                        )
                        (snd tuple)
                    )
                )
            ) words in

        (* 
            list of tuples (index, string)
            `index` as above
            `string` is a word
        *)
        let ordered_words =
            List.fold_left
                (fun a b -> a @ (List.map (fun x -> (fst b, x)) (snd b)))
                [] filtered_words in

        printf "\nWords for each line:\n";
        List.iter (fun tuple ->
            List.iter (fun word ->
                printf "%d %s\n" (fst tuple) (word)
                ) (snd tuple)
                ) words ;

        printf "\nOrdered Words:\n";
        List.iter (fun tuple -> printf "(%d,%s)\n" (fst tuple) (snd tuple)) ordered_words;

        let sorted_words = List.sort (fun t1 t2 -> String.compare (snd t1) (snd t2))
            (List.sort (fun t1 t2 -> compare (fst t1) (fst t2)) ordered_words) in
        
        printf "\nSorted Words:\n";
        List.iter (fun tuple -> printf "(%d,%s)\n" (fst tuple) (snd tuple)) sorted_words;

        printf "\nOutput:\n";
        List.iter (fun tuple ->
            let rec get_index_of l find i =
                match l with
                | hd :: tl when String.equal hd find ->
                    i
                | [] -> failwith "Nothing found"
                | hd :: tl ->
                    get_index_of tl find (i+1) in

            let index = fst tuple in
            let word = snd tuple in

            (* words associated with `index`*)
            let index_words = 
                match (List.find (fun x -> (fst x) = index) words) with
                | (_, l) -> l
                | _ -> [] in

            (* index of `word` in `index_words` *)
            let word_index =
                (get_index_of index_words (word) 0) in

            printf "%*d " 5 (index + 1);

            let rec join_to_nth l i start stop =
                if start > stop then
                    ""
                else
                    match l with
                    | _ when i = stop -> ""
                    | hd :: tl when i >= start -> hd ^ " " ^ (join_to_nth tl (i + 1) start stop)
                    | hd :: tl -> (join_to_nth tl (i + 1) start stop)
                    | [] -> "" in

            (* no need to be trimmed since already done. *)
            let to_be_printed_left =
                let joined_string_left = join_to_nth index_words 0 0 word_index in
                let length = String.length joined_string_left in
                if length > 33 then
                    String.sub joined_string_left (length - 33) 33
                else joined_string_left in

            printf "%*s " 33 to_be_printed_left;

            let to_be_printed_right =
                let joined_string_right =
                    let joined = join_to_nth index_words 0 word_index (List.length index_words) in
                    let dummy_string = String.make 40 ' ' in
                    String.mapi
                        (fun i c ->
                            match (joined.[i]) with
                            | joined_c -> joined_c
                            | exception Invalid_argument _ ->
                                if i = 39 then
                                    '.'
                                else ' '
                        )
                        dummy_string in
                joined_string_right in

            printf "%-*s " 40 to_be_printed_right;

            printf "\n";
        ) sorted_words;
    with e ->
        close_in_noerr ic;
        raise e
