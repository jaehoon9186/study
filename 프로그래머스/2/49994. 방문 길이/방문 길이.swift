import Foundation

struct Move: Hashable {
    let fromX: Int
    let fromY: Int
    let toX: Int
    let toY: Int
}

func solution(_ dirs:String) -> Int {
    let dict: [Character: (Int, Int)] = ["U": (1, 0), "D": (-1, 0), "L": (0, -1), "R": (0, 1)]
    var from = (0, 0)
    var walks = Set<Move>()
    
    
    for i in dirs {
        guard let pos = dict[i] else { break }
        let to = (from.0 + pos.0, from.1 + pos.1)
        
        if to.0 > 5 || to.0 < -5 || to.1 > 5 || to.1 < -5 {
            continue 
        }
        
        walks.insert(Move(fromX: from.0, fromY: from.1, toX: to.0, toY: to.1))
        walks.insert(Move(fromX: to.0, fromY: to.1, toX: from.0, toY: from.1))
        
        from = to
        
    }
    
    return walks.count / 2
}