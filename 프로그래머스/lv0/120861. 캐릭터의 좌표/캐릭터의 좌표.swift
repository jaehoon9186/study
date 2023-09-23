import Foundation

func solution(_ keyinput:[String], _ board:[Int]) -> [Int] {
    
    let move: [String: (Int, Int)] = ["up": (0, 1), "down": (0, -1), "left": (-1, 0), "right": (1, 0)]
    
    let (maxLeft, maxRight) = (-1 * (board[0] / 2), board[0] / 2)
    let (maxTop, maxBottom) = (-1 * (board[1] / 2), board[1] / 2)
    
    var result = [0, 0]
    
    for i in keyinput {
        let (a, b) = move[i]!
        
        if (result[0] + a >= maxLeft && result[0] + a <= maxRight) && (result[1] + b >= maxTop && result[1] + b <= maxBottom) {
            result[0] += a
            result[1] += b
        }
    }
    
    return result
}