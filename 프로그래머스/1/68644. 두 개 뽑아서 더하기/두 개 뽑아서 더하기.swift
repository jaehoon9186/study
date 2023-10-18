import Foundation

func solution(_ numbers:[Int]) -> [Int] {
    
    var result = Set<Int>()
    
    let sorted = numbers.sorted()
    
    for i in 0..<sorted.count - 1 {
        for j in i + 1..<sorted.count {
            result.insert(sorted[i] + sorted[j])
        }
    }
    
    return Array(result).sorted()
}