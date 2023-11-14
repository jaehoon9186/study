import Foundation

func solution(_ rows:Int, _ columns:Int, _ queries:[[Int]]) -> [Int] {
    
    var board: [[Int]] = []
    var result: [Int] = []
    
    for i in 0..<rows {
        board.append(((i*columns)+1...(i+1)*columns).map { $0 } )
    }
    
    for i in queries {
        let (startX, startY, endX, endY) = (i[1] - 1, i[0] - 1, i[3] - 1, i[2] - 1)
        
        var temp = board
        var moves: [Int] = []
        
        for i in startY...endY {
            for j in startX...endX {
                if i > startY && i < endY && j > startX && j < endX {
                    continue
                }
                
                let now = board[i][j]
                moves.append(now)
                
                if i == startY && j != endX {
                    temp[i][j+1] = now
                } else if j == endX && i != endY {
                    temp[i+1][j] = now
                } else if i == endY && j != startX {
                    temp[i][j-1] = now
                } else {
                    temp[i-1][j] = now
                }
            }
        }
        
        board = temp
        result.append(moves.min()!)
    }
    
    return result
}