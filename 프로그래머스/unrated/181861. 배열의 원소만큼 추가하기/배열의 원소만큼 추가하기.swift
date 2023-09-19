import Foundation

func solution(_ arr:[Int]) -> [Int] {
    return arr.flatMap { Array(repeating: $0, count: $0) }
}