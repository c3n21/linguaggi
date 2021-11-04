module Graph =
    struct
        type relationship = Friendship | Kinship | Financial | Dislike
        | Sexual | Beliefs | Knowledge | Prestige

        type graph = relationship Node.node list

        let rec addRelationshipNode this_graph this_node new_node tp =
            match this_graph with
            | hd :: tl ->
                Node.addAdjacent this_node new_node tp
    end
