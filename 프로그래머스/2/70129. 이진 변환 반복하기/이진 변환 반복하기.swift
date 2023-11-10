import Foundation

func solution(_ s:String) -> [Int] {
    var s = s
    var round = 0
    var zeroCount = 0
    
    while s.count > 1 {
        let tempLength = s.filter { $0 == "1" }.count
        let tempZero = s.filter { $0 == "0" }.count
        round += 1
        zeroCount += tempZero
        s = String(tempLength, radix: 2)
    }
     
    
    return [round, zeroCount]
}