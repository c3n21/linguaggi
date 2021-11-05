open Graph
open Printf

let () =
    print_string "Begin\n" ;
    let zhifan     = (Graph.create_node "Zhifan") in
    let simone     = (Graph.create_node "Simone") in
    let fipippo    = (Graph.create_node "Filippo") in
    let masicci    = (Graph.create_node "Sici") in
    let dovgayniuk = (Graph.create_node "Rostic") in
    let maggio     = (Graph.create_node "Maggio") in
    let luca       = (Graph.create_node "Luca") in

    (* let graph = ref (Graph.create ([!zhifan; !simone; !fipippo])) in *)
    let graph = ref Graph.create in
(*     let Node.addAdjacent !zhifan !simone Friendship ; *)

(*     zhifan := Graph.addRelationship !graph !zhifan !simone Friendship ; *)

    printf "After created\n" ;
    Graph.print_graph !graph ;

    printf "After addNode\n" ;
    graph    := Graph.addNode !graph zhifan ;
    graph    := Graph.addNode !graph simone ;
    Graph.print_graph !graph ;

    printf "After addAdjacent\n" ;
    graph := Graph.addEdge !graph zhifan simone Graph.Friendship ;
(*     graph := Graph.addNode !graph !masicci ; *)
(*     graph := Graph.addNode !graph !dovgayniuk ; *)
(*     graph := Graph.addNode !graph !maggio ; *)
(*     graph := Graph.addNode !graph !luca ; *)

(*     printf "After addNode\n" ; *)
(*     Graph.print !graph ; *)

    print_string "End\n" ;
