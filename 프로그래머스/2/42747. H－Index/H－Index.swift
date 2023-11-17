import Foundation

func solution(_ citations:[Int]) -> Int {
    
    let sorted = citations.sorted(by: >)
    var result = 0
    
    for i in zip(sorted, (1...sorted.count).map { $0 }) {
        if i.0 >= i.1 {
            result = i.1
        }
    }

    return result
}