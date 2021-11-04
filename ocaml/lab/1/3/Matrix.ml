(*
Write the matrix datatype with the following operations:

A function zeroes to construct a matrix of size n×m filled with zeros.
A function identity to construct the identity matrix (the one with all 0s but the 1s on the diagonal) of given size.
A function init to construct a square matrix of a given size n filled with the first n×n integers.
A function transpose that transposes a generic matrix independently of its size and content.
The basics operators + and * that adds and multiplies two matrices non necessarily squared.
 *)
(*
let rec zeroes n m =
  if n > 0 then
    [List.init m (function x -> 0)] :: zeroes (n-1) m
  else
    []

let rec print_matrix m =
  let rec print_list l =
    match l with
    [] -> ()
    | hd :: tl ->
        print_string "%s" hd
        print_list tl

  match m with
  [] -> ()
  | hd :: tl ->
      print_list hd
      print_matrix tl
*)

module Matrix =
  struct
    type matrix = int list list

    let rec zeroes n m =
      if n > 0 then
        lew l 
        zeroes (n-1) m
      else
        []
    let identity =
    let init =
    let transpose =
    let (+) =
    let (*) =
  end
