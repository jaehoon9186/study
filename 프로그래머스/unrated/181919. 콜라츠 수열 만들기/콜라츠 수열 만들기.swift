import Foundation

func solution(_ n:Int) -> [Int] {
    var x = n
    
    var result: [Int] = []
    
    while x != 1 {
        result.append(x)
        
        if x % 2 == 0 {
            x /= 2 
        } else {
            x = x * 3 + 1
        }
    }
    result.append(x)
    
    return result
}