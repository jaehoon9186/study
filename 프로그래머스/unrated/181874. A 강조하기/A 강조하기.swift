import Foundation

func solution(_ myString:String) -> String {
    
    var result = ""
    
    for i in myString.lowercased() {
        if i == "a" {
            result += String("A")
            continue
        }
        result += String(i)
    }
    
    return result
}