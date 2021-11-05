open Graph
open Printf

let zhifan     = (Graph.create_node "Zhifan"    )
let simone     = (Graph.create_node "Simone"    )
let fipippo    = (Graph.create_node "Filippo"   )
let masicci    = (Graph.create_node "Sici"      )
let dovgayniuk = (Graph.create_node "Rostic"    )
let maggio     = (Graph.create_node "Maggio"    )
let luca       = (Graph.create_node "Luca"      )

let friends = [zhifan; simone; fipippo; masicci; dovgayniuk; maggio; luca]

let graph = ref Graph.create


let () =
    print_string "Begin\n" ;

    printf "======== CREATED ========\n\n" ;
    Graph.print_graph !graph ;

    printf "\n\n======== ADD ALL NODES ========\n" ;
    List.iter (fun friend -> (graph := Graph.addNode !graph friend); ()) friends ;
    graph    := Graph.addNode !graph zhifan ;
    graph    := Graph.addNode !graph simone ;
    Graph.print_graph !graph ;

    printf "\n\n======== ADD REDUNDANT ========\n" ;
    graph := Graph.addEdge !graph zhifan simone     Graph.Friendship ;
    graph := Graph.addEdge !graph zhifan simone     Graph.Kinship    ;
    graph := Graph.addEdge !graph zhifan simone     Graph.Kinship    ;
    graph := Graph.addEdge !graph zhifan masicci    Graph.Knowledge;
    graph := Graph.addEdge !graph zhifan fipippo    Graph.Dislike;
    graph := Graph.addEdge !graph zhifan dovgayniuk Graph.Prestige;
    graph := Graph.addEdge !graph zhifan maggio     Graph.Financial;
    graph := Graph.addEdge !graph zhifan fipippo    Graph.Prestige;
    graph := Graph.addEdge !graph zhifan masicci    Graph.Financial;
    graph := Graph.addEdge !graph zhifan luca       Graph.Kinship    ;

    Graph.print_graph !graph ;

    print_string "End\n" ;
