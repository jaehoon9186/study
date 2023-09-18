import Foundation

func solution(_ numbers:[Int], _ n:Int) -> Int {
    var result = 0
    
    for i in numbers {
        if result <= n {
            result += i
        } else {
            break
        }
    }
    
    return result
}