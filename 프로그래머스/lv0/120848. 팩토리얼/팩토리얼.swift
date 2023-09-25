import Foundation

func solution(_ n:Int) -> Int {
    
    var num = 1
    var mul = 1
    
    while mul <= n {
        mul *= num
        num += 1
    }
    
    return num - 2
}