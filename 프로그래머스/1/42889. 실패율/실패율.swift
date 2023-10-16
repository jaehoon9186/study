import Foundation

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    
    var sorted = stages.sorted(by: >)
    var result: [Double] = []
    
    for i in 1...N {
        let total = sorted.count
        
        var fail = 0
        
        while let a = sorted.last, a <= i {
            fail += 1
            sorted.popLast()
        } 
        result.append(Double(fail) / Double(total))
    }
    
    
    return result.enumerated().sorted { $0.1 > $1.1 }.map { $0.offset + 1 }
}