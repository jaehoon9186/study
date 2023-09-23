import Foundation

func solution(_ n:Int) -> Int {
    
    var num = 1
    var list: [Int] = []
    
    while list.count < n {
        if num % 3 != 0 && String(num).contains("3") == false {
            list.append(num)
            
        }
        
        num += 1
    }
    
    return list.last!
}