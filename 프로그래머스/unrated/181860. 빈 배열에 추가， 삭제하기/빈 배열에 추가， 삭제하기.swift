import Foundation

func solution(_ arr:[Int], _ flag:[Bool]) -> [Int] {
    
    var result: [Int] = []
    
    for (v, f) in zip(arr, flag) {
        if f {
            (0..<(v * 2)).forEach { _ in
                result.append(v)
            }
        } else {
            (0..<v).forEach { _ in
                result.popLast()
            }
        }
    }
    
    
    return result
}