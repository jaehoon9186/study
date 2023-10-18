import Foundation

func solution(_ left:Int, _ right:Int) -> Int {
    return (left...right).map { [$0, divCount($0)] }.map { $0[1] % 2 == 0 ? $0[0] : -$0[0] }.reduce(0, +)
}

func divCount(_ num: Int) -> Int {
    var count = 0
    
    for i in 1...num {
        if num % i == 0 {
            count += 1
        }
    }
    
    return count
}