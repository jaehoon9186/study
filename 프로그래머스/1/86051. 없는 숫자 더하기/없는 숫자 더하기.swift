import Foundation

func solution(_ numbers:[Int]) -> Int {
    return (0...9).reduce(0, +) - numbers.reduce(0, +)
}