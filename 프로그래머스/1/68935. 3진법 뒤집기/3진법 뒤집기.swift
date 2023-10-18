import Foundation

func solution(_ n:Int) -> Int {
    
    var third = ""
    var n = n
    
    while n > 0 {
        third = String(n % 3) + third
        n /= 3
    }
    
    return Int(String(third.reversed()), radix: 3) ?? 0
}