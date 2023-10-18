import Foundation

func solution(_ absolutes:[Int], _ signs:[Bool]) -> Int {
    return zip(absolutes, signs).map { $0 * ($1 ? 1 : -1) }.reduce(0, +)
}