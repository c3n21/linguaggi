module type PRIOQUEUE =
    sig
        type priority = int         (* still concrete *)
        type 'a queue               (* now abstract *)
        val empty : 'a queue
        val insert : 'a queue -> int -> 'a -> 'a queue
        val extract : 'a queue -> int * 'a * 'a queue
        exception Queue_is_empty
    end;;
