module type TREE = sig
    (* type 'a node = Empty | Node of {element: 'a; right: 'a node; left: 'a node} *)
    type node = Empty
    val new: node
    val prova
end
