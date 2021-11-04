open Printf

module Graph =
    struct
        type relationship = Friendship | Kinship | Financial | Dislike
        | Sexual | Beliefs | Knowledge | Prestige

        type graph = Graph of relationship Node.node list
        type node = Node of string

        let create nodes =
            Graph nodes

        let addNode graph new_node =
            match graph with
            | Graph nodes ->
                match List.find (fun x -> x = new_node) nodes with
                | exception Not_found ->
                    Graph (new_node :: nodes)
                | _ -> Graph nodes

        let addRelationship this_graph this_node other_node tp =
            match this_graph with
            | Graph l ->
                let f x =
                    x = this_node in
                match List.find f l with
                | exception Not_found -> failwith "This node is not in the graph"
                | f_node -> Node.addAdjacent f_node other_node tp

        let print this =
            printf "Printing graph\n" ;
            let f x =
                match x with
                | Friendship -> "Friendship"
                | Kinship -> "Kinship"
                | Financial -> "Financial"
                | Dislike -> "Dislike"
                | Sexual -> "Sexual"
                | Beliefs -> "Beliefs"
                | Knowledge-> "Knowledge"
                | Prestige -> "Prestige" in
            match this with
            | Graph nodes ->
                let p x =
                    Node.print x f in
                List.iter p nodes
    end
