import Foundation

func solution(_ hp:Int) -> Int {
    let ants = [5, 3, 1]
    var hp = hp
    var result = 0
    
    for i in ants {
        result += hp / i
        hp %= i
    }
    
    return result
}