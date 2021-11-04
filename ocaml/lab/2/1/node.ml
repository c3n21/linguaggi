(* label is the identifier for a node *)
(* `adjacents` is a list of pairs of `'a node` and `'a`, where `'a` is the type of the edge with `'a node`. *)
(* A node can be linked to another one multiple times as long as it's a different type of edge, aka a different 'a *)
type 'a node = {label: string; adjacents: ('a node * 'a list) list}

let create l adj =
    {label = l; adjacents = adj}

(* add `new_adjacent` node in the list of the adjacents for `this` if `t` type edge doesn't exist *)
    (* otherwise return this *)
let addAdjacent this new_adjacent t=
    match this with
    | {label = l; adjacents = ads} ->
        let f n =
            match n with
            | ({label = l2; adjacents = _},_) when l = l2 -> true
            | _ -> false in

        match List.find f ads with
        (* tuple doesn't exist, so create*)
        | exception Not_found ->
            {label = l; adjacents = (new_adjacent, t :: []) :: ads}
        (* tuple exist, so look for `t` type edge *)
        | ({label = f_l; adjacents = f_ads}, rs) ->
            let is_t_type x =
                if x = t then true
                else false in
            match List.exists is_t_type rs with
            | exception Not_found ->
                {label = l; adjacents = (new_adjacent, t :: rs) :: f_ads}
            | _ -> this

let rec print_all this =
    open Printf;
    match this with
    | {label = l; adjacents = ads} ->
        printf "%s \n";
        let f x =
            match x with
            | {label = x_l; adjacents = _} -> printf "label = %s"
        in

        List.iter f 
