import Foundation

func solution(_ numbers:[Int]) -> Int {
    
    var sorted = numbers.sorted()
    
    return sorted.popLast()! * sorted.popLast()!
}