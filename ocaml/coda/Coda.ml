
module Coda = struct
        type coda = Empty | Elem of int * coda
        let empty = Empty
        let rec push x = function
                  Empty -> Elem(x, Empty)
                | Elem(v, next) -> Elem(v, push x next)
        let rec pop = function
            Elem(v, next)  ->
                      if next == Empty then Empty 
                      else Elem(v, pop next)
                | Empty -> Empty
        let rec length = function
              Empty -> 0
            | Elem(_, next) -> ((length next) + 1)   
        (*exception EmptyException of string*)
        let rec top = function
              Empty          -> 0 (*raise (EmptyException "coda vuota")*)
            | Elem(v, Empty) -> v
            | Elem(_, next)  -> top next
end

(* let y = Coda.push 5 Empty let y = Coda.push 6 y Coda.length y let y = Coda.pop y Coda.length y Coda.top y let y = Coda.pop y Coda.top y*)
