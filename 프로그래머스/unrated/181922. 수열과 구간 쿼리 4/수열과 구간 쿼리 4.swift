import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    
    var result = arr
    
    queries.forEach {
        let (s, e, k) = ($0[0], $0[1], $0[2])
        (s...e).filter { index in index % k == 0 }.map { index in result[index] += 1 }
    }
    
    return result
}