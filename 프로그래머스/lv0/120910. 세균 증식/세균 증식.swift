import Foundation

func solution(_ n:Int, _ t:Int) -> Int {
    
    var result = n
    
    (0..<t).forEach { _ in
        result *= 2
    }
    
    return result
}