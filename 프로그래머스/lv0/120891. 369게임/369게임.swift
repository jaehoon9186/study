import Foundation

func solution(_ order:Int) -> Int {
    return String(order).map { $0 }.filter { ["3","6","9"].contains($0) }.count
}