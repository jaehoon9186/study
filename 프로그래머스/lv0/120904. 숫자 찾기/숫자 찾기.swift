import Foundation

func solution(_ num:Int, _ k:Int) -> Int {
    var result = -1
    
    for (i, v) in String(num).enumerated() {
        if Int(String(v))! == k {
            return i + 1
        }
    }
    
    return result
}