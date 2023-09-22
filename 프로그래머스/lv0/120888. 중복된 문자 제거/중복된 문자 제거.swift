import Foundation

func solution(_ my_string:String) -> String {
    
    var check: [Character: Bool] = [:]
    var result: String = ""
    
    for i in my_string {
        if check[i, default: false] == false {
            result += String(i)
            check[i] = true
        }
    }
    
    
    return result
}