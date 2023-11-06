import Foundation

func solution(_ s:String) -> [Int] {
    
    let allNumbers = s.components(separatedBy: ["{", ",", "}"]).filter { $0.isEmpty == false }.map { Int($0)! }
    var dict: [Int: Int] = [:]
    allNumbers.forEach { dict[$0, default: 0] += 1 }
    
    return dict.sorted { $0.value > $1.value }.map { $0.key }
}