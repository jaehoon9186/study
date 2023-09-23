import Foundation

func solution(_ board:[[Int]]) -> Int {
    
    var board2 = board
    let move = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    
    for i in 0..<board.count {
        for j in 0..<board[0].count {
            if board[i][j] == 1 {
                for k in move {
                    if (i + k.0 >= 0 && i + k.0 < board.count) &&
                        (j + k.1 >= 0 && j + k.1 < board[0].count) {
                        board2[i + k.0][j + k.1] = 1        
                    }
                }
            }
        }
    }
    
    return board2.flatMap { $0 }.filter { $0 == 0 }.count
}