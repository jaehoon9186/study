import Foundation

func solution(_ n:Int) -> Int {
    
    var c = 1 
    
    while (6 * c) % n != 0 {
        c += 1
    }
    
    return c
}