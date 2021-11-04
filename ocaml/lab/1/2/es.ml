type t_unit = Celsius | Kelvin | Fahrenheit | Rankine | Delisle | Newton | Reaumur | Romer ;;

type temperature = { t: float; tp: t_unit } ;;

let celsius n =
  { t = n; tp = Celsius } ;;


let main () =
  print_string "Ceo\n" ;;

main () ;;
