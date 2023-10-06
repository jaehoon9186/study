import Foundation

func solution(_ emergency:[Int]) -> [Int] {
    
    var dict: [Int: Int] = [:]
    
    for (i, v) in emergency.sorted(by: >).enumerated() {
        dict[v] = i + 1
    } 
    
    
    return emergency.map { dict[$0] ?? 0 }
}