import Foundation

struct Node: Hashable {
    var y: Int
    var x: Int
    var d: Int
}

func solution(_ grid:[String]) -> [Int] {
    
    let grid = grid.map { $0.map { String($0) } }
    
    // direction(before -> now) index
    // 왼쪽에서 왔을때, 오른쪽에서 왔을때, 위에서 왔을때, 아래서 왔을때 
    let nextDirection: [String: [(Int, Int)]] = [
        "S" : [(0,1), (0,-1), (1,0), (-1,0)],
        "L" : [(-1,0), (1,0), (0,1), (0,-1)],
        "R" : [(1,0), (-1,0), (0,-1), (0,1)]
    ]
    
    // [nowY, X, direction(before -> now)]
    var visitedSet = Set<Node>()
    
    var result: [Int] = []
    
    // 모든 경로 탐색하면서 이미 탐색한 곳은 제외
    for i in 0..<grid.count {
        for j in 0..<grid[i].count {
            for k in [0, 1, 2, 3] { // 4방향
                
                if visitedSet.contains(Node(y: i, x: j, d: k)) { continue }
                
                var cycleSet = Set<Node>()
                
                var nowY = i
                var nowX = j
                var direc = k
                
                while cycleSet.contains(Node(y: nowY, x: nowX, d: direc)) == false {
                    
                    visitedSet.insert(Node(y: nowY, x: nowX, d: direc)) 
                    cycleSet.insert(Node(y: nowY, x: nowX, d: direc))
                    
                    let symbol = grid[nowY][nowX]
                    let nextYX = nextDirection[symbol]![direc]
                    
                    var nextY = nowY + nextYX.0
                    var nextX = nowX + nextYX.1
                    
                    // direc update
                    switch (nowY - nextY, nowX - nextX) {
                        case (0, -1):
                            direc = 0
                        case (0, 1):
                            direc = 1
                        case (-1, 0):
                            direc = 2
                        default:
                            direc = 3
                        
                    }
                    
                    // next 예외처리
                    if nextY < 0 {
                        nextY = grid.count - 1
                    } else if nextY >= grid.count {
                        nextY = 0
                    }
                    if nextX < 0 {
                        nextX = grid[0].count - 1
                    } else if nextX >= grid[0].count {
                        nextX = 0
                    }
                    
                    nowY = nextY
                    nowX = nextX
                    
                }
                result.append(cycleSet.count)
            }
        }
    }
    
    
    return result.sorted()
}