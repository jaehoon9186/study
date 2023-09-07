import Foundation

func solution(_ start:Int, _ end_num:Int) -> [Int] {
    return stride(from: start, to: end_num - 1, by: -1).map { $0 }
}