import Foundation

func solution(_ box:[Int], _ n:Int) -> Int {
    return box.reduce(1) { $0 * ($1 / n) }
}