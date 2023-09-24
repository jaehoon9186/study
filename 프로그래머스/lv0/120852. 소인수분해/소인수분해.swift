import Foundation

func solution(_ n:Int) -> [Int] {
    
    var result = Set<Int>()
    var num = n
    var div = 2
    
    while num > 1 {
        if num % div == 0 {
            result.insert(div)
            num /= div
        } else {
            div += 1
        }
    }
    
    return Array(result).sorted()
}