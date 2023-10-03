import Foundation

func solution(_ n:Int) -> Int {
    var list: [Bool] = Array(repeating: true, count: 101)
    
    for i in 2...50 {
        if list[i] == false {
            continue
        }
        for j in stride(from: i + i, to: 101, by: i) {
            list[j] = false
        }
    }
    
    let hapNumList = list.enumerated().filter { $1 == false }.map { $0.offset }
    
    
    return (0...n).filter { hapNumList.contains($0) }.count
}