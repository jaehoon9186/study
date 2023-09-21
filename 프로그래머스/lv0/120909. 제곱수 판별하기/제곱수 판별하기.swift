import Foundation

func solution(_ n:Int) -> Int {
    let temp = Int(Double(n).squareRoot())
    return temp * temp == n ? 1 : 2
}