import Foundation

func solution(_ price:Int, _ money:Int, _ count:Int) -> Int64 {
    let total = (1...count).map { price * $0 }.reduce(0, +)
    
    return total - money > 0 ? Int64(total - money) : 0
}