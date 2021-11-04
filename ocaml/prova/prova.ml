let succ = fun x -> x+1;;
let main() =
  print_string("Hello world!\n");;
  Printf.printf "succ 3 = %d\n" (succ 3);;

  open ModuleProva.PrioQueue

  let root = empty;;
  let a = insert root 9 'c';;

main();;
