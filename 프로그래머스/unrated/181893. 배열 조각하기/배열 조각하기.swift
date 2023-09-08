import Foundation

func solution(_ arr:[Int], _ query:[Int]) -> [Int] {
    
    var result = arr
    
    for (i, v) in query.enumerated() {
        if i % 2 == 0 {
            result = Array(result[...v])
        } else {
            result = Array(result[v...])
        }
    }
    
    return result
}