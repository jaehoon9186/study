import Foundation

func solution(_ n:Int, _ words:[String]) -> [Int] {
    
    var result = [0, 0]
    
    for i in 1..<words.count {
        guard let a = words[i - 1].last, let b = words[i].first else { break }
        if a != b || words[0..<i].contains(words[i]) {
            result[0] = i % n + 1
            result[1] = i / n + 1
            break
        }
    }
    
    return result
}