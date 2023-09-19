import Foundation

func solution(_ arr:[Int]) -> [Int] {
    
    var result: [Int] = []
    
    for v in arr {
        if result.isEmpty {
            result.append(v)
            continue
        }
        
        if let a = result.last, a == v {
            result.popLast()
        } else {
            result.append(v)
        }
        
    }
    
    return result.isEmpty ? [-1] : result
}