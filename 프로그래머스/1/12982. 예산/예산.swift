import Foundation

func solution(_ d:[Int], _ budget:Int) -> Int {
    
    let sorted = d.sorted()
    var sum = 0
    var count = 0
    
    for i in sorted {
        if sum + i <= budget {
            sum += i
            count += 1
        } else {
            break
        }
    }
    
    
    
    return count
}