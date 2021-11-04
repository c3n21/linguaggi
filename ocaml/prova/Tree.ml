module Tree : TREE = struct
    type 'a node = Empty | Node of {element: 'a; right: 'a node; left: 'a node}
    let new el = 
        let prova = Node {element: el; right: Empty; left: Empty}
end

