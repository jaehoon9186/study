import Foundation

func solution(_ n:Int, _ edge:[[Int]]) -> Int {
    
    var nodes =  Array(repeating: [Int](), count: n + 1)
    var distance = Array(repeating: 0, count: n + 1)
    
    for e in edge {
        let (u, v) = (e[0], e[1])
        
        nodes[u].append(v)
        nodes[v].append(u)
    }
    
    func bfs(_ start: Int) {
        var visited = Array(repeating: false, count: n + 1)
        var queue = [Int]()
        
        queue.append(start)
        visited[start] = true
        
        while queue.isEmpty == false {
            let now = queue.removeFirst()

            for i in nodes[now] {
                if visited[i] == false {
                    visited[i] = true
                    queue.append(i)
                    distance[i] = distance[now] + 1
                }
            }
        }
        
    }
    
    bfs(1)
    
    let maxCount = distance.max()    
    
    return distance[1...].filter { $0 == maxCount }.count
}