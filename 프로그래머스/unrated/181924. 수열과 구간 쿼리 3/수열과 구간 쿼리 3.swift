import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var result = arr
    for q in queries {
        let (first, second) = (q[0], q[1])
        (result[first], result[second]) = (result[second], result[first])
    }
    
    return result
}