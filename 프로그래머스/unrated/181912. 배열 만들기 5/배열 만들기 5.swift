import Foundation

func solution(_ intStrs:[String], _ k:Int, _ s:Int, _ l:Int) -> [Int] {
    
    var result: [Int] = []
    for i in intStrs {
        let num = Int(Array(i.map {String($0)}[s..<(s+l)]).joined())
        if let a = num, a > k {
            result.append(a)
        } 
    }
    return result
}