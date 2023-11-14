import Foundation

func solution(_ places:[[String]]) -> [Int] {
    
    var places = places.map { $0.map { $0.map { $0 } } }
    var result: [Int] = []
    
    for i in places {
        result.append(isPossible(i) ? 1 : 0 )
    }
    
    return result
}

func isPossible(_ list : [[Character]]) -> Bool {
    
    
    for i in 0..<list.count {
        for j in 0..<list[i].count {
            
            if list[i][j] != "P" {
                continue
            }
            
            // P
            if isNearbyP(list, i, j) == false {
                return false
            }
        }
    }
    
    return true
}

func isNearbyP(_ list: [[Character]], _ y: Int, _ x: Int) -> Bool {
    
    let dx = [0, 0,1,-1]
    let dy = [-1,1,0, 0]
    
    let maxRow = list.count - 1
    let maxColumn = list[0].count - 1
    
    var stack: [(Int, Int)] = []
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 5), count: 5)
    visited[y][x] = true
    stack.append((y, x))
    
    while stack.count > 0 {
        let pop = stack.removeLast()
        
        for i in 0..<4 {
            let (ny, nx) = (pop.0 + dy[i], pop.1 + dx[i])
            
            if abs(y - ny) + abs(x - nx) > 2 { continue }
            if ny < 0 || ny > maxRow || nx < 0 || nx > maxColumn { continue }
            if list[ny][nx] == "X" { continue }
            if visited[ny][nx] == true { continue }
            
            if list[ny][nx] == "P" {
                return false
            }
            
            stack.append((ny, nx))
            visited[ny][nx] = true
        }    
    }
    
    return true
}