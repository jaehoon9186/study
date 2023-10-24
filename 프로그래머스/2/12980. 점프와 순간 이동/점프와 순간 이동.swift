import Foundation

/*
func solution(_ n:Int) -> Int {
    var list = Array(repeating: 0, count: n + 1)
    list[1] = 1
    
    for i in 2...n {
        if i % 2 == 0 {
            list[i] = min(list[i - 1] + 1, list[i / 2])
        } else {
            list[i] = list[i - 1] + 1
        }
    }
    
    return list[n]
}
*/

func solution(_ n:Int) -> Int {
    
    var result = 0
    var n = n
    
    while n > 0 {
        if n % 2 == 0 {
            n /= 2
        } else {
            n -= 1
            result += 1
        }
    }
    
    return result
}