import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    
    var result = arr
    
    for i in queries {
        for j in (i[0]...i[1]) {
            result[j] += 1
        }
    }
    
    return result
}