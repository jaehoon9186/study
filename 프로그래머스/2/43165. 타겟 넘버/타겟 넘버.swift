import Foundation

func solution(_ numbers:[Int], _ target:Int) -> Int {
    
    var result = 0
    
    for i in 0..<(1 << numbers.count) {
        
        var temp = 0
        for j in 0..<numbers.count {
            // +
            if i & (1 << j) != 0 {
                temp += numbers[j]
            } else { // -
                temp -= numbers[j]
            }
        }
        if temp == target {
            result += 1
        }
    }
    
    return result
}