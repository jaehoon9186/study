import Foundation

func solution(_ array:[Int]) -> [Int] {
    
    let result = array.enumerated().sorted { $0.element > $1.element }[0]
    
    return [result.element, result.offset]
}