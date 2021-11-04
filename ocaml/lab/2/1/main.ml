open Graph
open Printf

let () =
    print_string "Begin\n" ;
    let zhifan     = ref (Node.create "Zhifan" []) in
    let simone     = ref (Node.create "Simone" []) in
    let fipippo    = ref (Node.create "Filippo" []) in
    let masicci    = ref (Node.create "Sici" []) in
    let dovgayniuk = ref (Node.create "Rostic" []) in
    let maggio     = ref (Node.create "Maggio" []) in
    let luca       = ref (Node.create "Luca" []) in

    let graph = ref (Graph.create ([!zhifan; !simone; !fipippo])) in

    let Node.addAdjacent !zhifan !simone Friendship ;

    zhifan := Graph.addRelationship !graph !zhifan !simone Friendship ;

    printf "After created\n" ;

    Graph.print !graph ;
    graph := Graph.addNode !graph !masicci ;
    graph := Graph.addNode !graph !dovgayniuk ;
    graph := Graph.addNode !graph !maggio ;
    graph := Graph.addNode !graph !luca ;

    printf "After addNode\n" ;
    Graph.print !graph ;

    print_string "End\n" ;
