module PrioQueue =
  struct 
    type priority = int
    type char_queue =
        Empty
      | Node of priority * char * char_queue * char_queue

    exception QueueIsEmpty
    
    let empty = Empty

    let rec insert q priority el =
      match q with
      Empty -> Node(priority, el, Empty, Empty)
      | Node(p, e, left, right) ->
        if priority <= p
        then Node(priority, el, insert right p e, left)
        else Node(p, e, insert right priority el, left)

    let rec remove_top = function
      Empty -> raise QueueIsEmpty
    | Node(priority, elt, left, Empty) -> left
    | Node(priority, elt, Empty, right) -> right
    | Node(priority, elt, (Node(lprio, lelt, _, _) as left),
    (Node(rprio, relt, _, _) as right))->
        if lprio <= rprio
        then Node(lprio, lelt, remove_top left, right)
        else Node(rprio, relt, left, remove_top right)

    let extract = function
      Empty -> raise QueueIsEmpty
      | Node(priority, elt, _, _) as queue -> (priority, elt, remove_top queue)
  end
