import Foundation

func solution(_ board:[[Int]], _ moves:[Int]) -> Int {
    
    var result = 0
    var list: [Int] = []
    var board = board
    
    for j in moves {
        for i in 0..<board.count {
            let temp = board[i][j - 1]
            if temp == 0 {
                continue
            }
            
            board[i][j - 1] = 0
            
            if let a = list.last, a == temp {
                list.popLast()
                result += 2
            } else {
                list.append(temp)
            }
            
            break
        }
    }
    
    return result
}