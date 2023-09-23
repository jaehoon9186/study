import Foundation

func solution(_ my_string:String) -> Int {
    
    var result = 0
    var temp = ""
    
    for i in my_string {
        if i.isNumber {
            temp += String(i)
        } else {
            result += Int(temp) ?? 0
            temp = ""
        }
    }
    
    if temp.isEmpty == false {
        result += Int(temp)!
    }
    
    return result
}