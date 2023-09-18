import Foundation

func solution(_ num_list:[Int]) -> Int {
    var result = 0
    
    for i in num_list {
        var num = i
        while num > 1 {
            result += 1
            num = num % 2 == 0 ? num / 2 : (num - 1) / 2
        }
    }
    
    return result
}