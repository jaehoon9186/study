import Foundation

func solution(_ chicken:Int) -> Int {
    
    var chicken = chicken
    
    var sum = 0
    
    while chicken > 9 {
        sum += ( chicken / 10 )
        chicken = (chicken / 10) + (chicken % 10)
        
    }
    
    return sum
}