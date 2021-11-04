(*
open Printf
(*
Put into a list, called alkaline_earth_metals, the atomic numbers of the six
alkaline earth metals: beryllium (4), magnesium (12), calcium (20), strontium (38), barium (56), and radium (88). Then

  1. Write a function that returns the highest atomic number in alkaline_earth_metals.
  2. Write a function that sorts alkaline_earth_metals in ascending order (from the lightest to the heaviest).

  Put into a second list, called noble_gases, the noble gases: helium (2), neon (10),
  argon (18), krypton (36), xenon (54), and radon (86). Then

  3. Write a function (or a group of functions) that merges the two lists and print the result as couples (name, atomic number) sorted in ascending order on the element names.
 *)

let alkaline_earth_metals = [
  ("beryllium", 4);
  ("magnesium", 12);
  ("calcium", 20);
  ("strontium", 38);
  ("barium", 56);
  ("radium", 88)
]

let print_tuple tuple =
  match tuple with
  (metal, atom) -> printf "(%s,%d)\n" metal atom

let rec highest l =
  match l with
  [] -> None
  | hd :: tl ->
      match hd with
      (metal, atom) ->
        match highest tl with
        None -> Some hd
  | Some other  ->
      match other with
      (other_metal, other_atom) ->
        if atom < other_atom then
          Some other
        else
          Some hd

let remove_element l e =
  match l with
  [] -> []
  | hd :: tl ->
    if hd == e then
      tl
    else
      hd :: (poll_element tl e)

let rec sort_helper l =
  match l with
  [] -> []
  | hd :: tl ->
    let h = (highest l)
    (sort_helper (remove_element l h)) @ [h];;

(*
let sort l =
  (sort_helper l)
*)
let main () =
  match (highest alkaline_earth_metals) with
  Some tuple -> print_tuple tuple
  | None -> printf "None"

main ();;
*)


let alkaline_earth_metals = ("beryllium", 4)::("magnesium", 12)::("calcium", 20)::("strontium", 38)::("barium", 56)::("radium", 88)::[] ;;

let noble_gases = [("helium", 2); ("neon", 10); ("argon", 18); ("krypton", 36); ("xenon", 54); ("radon", 86)] ;;

let (>:) a b = (snd a) - (snd b);;
let max a b = if (a >: b >= 0) then a else b ;;

let heaviest lst = 
  List.fold_left max (List.hd lst) (List.tl lst) ;;

let sort_ascending lst = List.sort (>:) lst ;;

let merge_elements metals gases =
  (*
  let sorted_metals = sort_ascending metals and 
      sorted_gases =  sort_ascending gases in
      List.merge (>:) sorted_metals sorted_gases ;;
*)
  let sorted_metals = sort_ascending metals and
    sorted_gases = sort_ascending gases in
  List.merge (>:) sorted_metals sorted_gases ;;

let print_list f lst = 
  let rec print_list = function
    []     -> ()
  | hd::[] -> f hd
  | hd::tl -> f hd ; print_string ", " ; print_list tl 
in print_string "[" ; print_list lst ; print_string "]\n" ;;

let print_pair a =
  Printf.printf "(%s, %d)" (fst a) (snd a) ;;

let main() =
  let m = (heaviest alkaline_earth_metals) and
      sorted_aem = sort_ascending alkaline_earth_metals in
    Printf.printf "The heaviest element is «%s» with «%2d» as atomic number.\n" (fst m) (snd m) ;
    print_list print_pair sorted_aem ;
    print_list print_pair (merge_elements alkaline_earth_metals noble_gases) ;;

main() ;;
