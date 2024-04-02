// import Foundation

func solution(_ a:[Int], _ b:[Int]) -> Int {
    
    var result = 0
    
    var sortedA = a.sorted(by: >)
    var sortedB = b.sorted(by: >)
    
    var j = 0
    
    for i in 0..<a.count {
        if sortedA[i] < sortedB[j] {
            j += 1
            result += 1
        }
    }
    
    
    return result 
}