import Foundation

func solution(_ n:Int) -> Int {
    
    var c = 1
    
    while 7 * c < n {
        c += 1
    }
    
    
    return c
}