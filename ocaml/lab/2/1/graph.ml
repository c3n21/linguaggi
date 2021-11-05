open Printf

let debug = true

module Graph =
    struct
        type relationship = Friendship | Kinship | Financial | Dislike
        | Sexual | Beliefs | Knowledge | Prestige
        type node = Node of string
        type edge = Edge of (relationship * node list)
        type graph = Graph of (node * edge list) list

        let print_edge edge =
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
            match edge with
            | Edge (y_rel, y_adjacents) ->
            printf "\tRelationship: %s, Nodes: [ %s\b ]\n" (f y_rel)
                (List.fold_left (fun a b -> match b with | Node s -> a ^ s ^ ",") "" y_adjacents)

        let print_node node =
            match node with
            | Node s -> printf "Node: '%s'\n" s

        let print_graph this_graph =
            match this_graph with
            | Graph nodes ->
                let p x =
                    print_node (fst x) ;
                    List.iter print_edge (snd x) in
                List.iter p nodes

        let create_node l =
            Node l

        let create =
            Graph []

        let addNode graph new_node =
            match graph with
            | Graph l ->
                match List.find (fun x -> fst x = new_node) l with
                | exception Not_found -> Graph ((new_node, []) :: l)
                | _ -> graph

        let partitionNodes p this_graph =
            match this_graph with
            | Graph l ->
                List.partition p l

        let partitionEdges p this_edges =
            List.partition p this_edges

        let rec addEdge this_graph src_node dst_node rel =
            (* Adds and edge with `rel` relationship between src_node and dst_node
               (and viceversa) if they are both in the graph *)
            match (partitionNodes (fun x -> fst x = src_node) this_graph) with
            | ([],_) -> this_graph
            | ([src], other_nodes) ->
                let src_edges = snd src in
                let other_edges = List.map (fun x -> snd x) other_nodes in
                match (partitionEdges (fun x -> match x with | Edge t -> fst t = rel) src_edges) with
                (* exists *)
                | ([Edge (src_rel, src_adjacents)], src_other_rel_edges) -> 
                    if not (List.exists (fun x -> x = dst_node) src_adjacents) then
                        let src_new_edge = Edge (rel, dst_node :: src_adjacents) in
                        addEdge (Graph (((src_node),src_new_edge :: src_other_rel_edges) :: other_nodes))
                            dst_node src_node rel
                    else
                        this_graph
                (* no exists *)
                | ([], src_other_rel_edges) ->
                    let src_new_edge = Edge (rel, dst_node :: []) in
                    addEdge (Graph ((src_node, (src_new_edge) :: src_other_rel_edges) :: other_nodes))
                        dst_node src_node rel
                (* exists multiple times, which shouldn't be*)
                | (true_edges, false_edges) ->
                    if debug then
                        printf "true edges\n" ;
                        List.iter print_edge true_edges ;
                        printf "false_edges\n" ;
                        List.iter print_edge false_edges;
                    failwith "Same relationship multiple times in src_node"

    end
