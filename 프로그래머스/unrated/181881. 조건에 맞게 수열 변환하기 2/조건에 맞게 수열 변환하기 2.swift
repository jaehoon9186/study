import Foundation

func solution(_ arr:[Int]) -> Int {
    
    var arr = arr
    var temp: [Int] = []
    var result = 0
    
    while true {
        result += 1
        
        temp = arr.map { $0 >= 50 && $0 % 2 == 0 ? $0 / 2 : ($0 < 50 && $0 % 2 == 1 ? $0 * 2 + 1 : $0 )}
        
        if arr == temp {
            result -= 1
            break
        }
        
        arr = temp 
    }
    

    
    return result
}