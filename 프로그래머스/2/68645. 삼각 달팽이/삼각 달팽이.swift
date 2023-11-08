import Foundation

func solution(_ n:Int) -> [Int] {
    
    var lists: [[Int]] = []
    
    var count = 1
    var nx = -1
    var ny = 0
    
    let dx = [1, 0, -1]
    let dy = [0, 1, -1]
    var d = 0
    var dCountMax = n  // 한방향으로 이동할 MAX value
    var dCount = dCountMax // -1 씩 감소, 0이되면 방향전환
    
    for i in 1...n {
        lists.append(Array(repeating: 0, count: i))
    }
    
    if n == 1 {
        return [1]
    }
    
    while dCountMax > 1 {
        
        if dCount == 0 {
            d = (d + 1) % 3
            dCountMax -= 1 
            dCount = dCountMax
        } 
       
        nx += dx[d]
        ny += dy[d]
        lists[nx][ny] = count
        
        count += 1
        dCount -= 1
    }
    
    return lists.flatMap { $0 }
}