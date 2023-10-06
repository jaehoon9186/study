import Foundation

func solution(_ n:Int) -> [Int] {
    return stride(from: 1, to: n + 1, by: 2).map { $0 } 
}