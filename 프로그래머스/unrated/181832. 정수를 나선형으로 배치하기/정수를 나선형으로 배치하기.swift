import Foundation

func solution(_ n:Int) -> [[Int]] {
    
    var result = Array(repeating: Array(repeating: 0, count: n) , count: n)
    
    var i = 0
    var j = -1
    
    var maxCount = n
    var value = 1
    var idxMove = 1
    
    while maxCount > 0 {
        for _ in (0..<maxCount) {
            j = j + idxMove
            result[i][j] = value
            value += 1
        }
        
        maxCount -= 1
        
        for _ in (0..<maxCount){
            i = i + idxMove
            result[i][j] = value
            value += 1
        }
        
        idxMove *= -1
        
    }
    
    return result
}