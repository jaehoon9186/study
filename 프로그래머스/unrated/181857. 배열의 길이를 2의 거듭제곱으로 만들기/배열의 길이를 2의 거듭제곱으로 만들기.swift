import Foundation

func solution(_ arr:[Int]) -> [Int] {
    
    var count = arr.count
    var check = count - 1
    
    while count & check != 0 {
        count += 1
    }
    
    return arr + Array(repeating: 0, count: count - arr.count)
}