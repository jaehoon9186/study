import Foundation

func solution(_ n:Int) -> Int {
    
    var a = 1
    var b = n
    var result = 0
    
    while a <= n {
        if a * b == n {
            result += 1
        }
        a += 1
        b = n / a
    }
    
    return result
}