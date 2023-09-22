import Foundation

func solution(_ n:Int) -> [Int] {
    
    if n < 2 {
        return [n]
    }
    
    var result: [Int] = []
    
    for i in 1...(n / 2) {
        if n % i == 0 {
            result.append(i)
        }
    }
    
    result.append(n)
    
    return result
}