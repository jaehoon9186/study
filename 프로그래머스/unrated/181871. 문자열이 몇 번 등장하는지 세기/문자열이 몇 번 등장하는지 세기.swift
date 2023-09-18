import Foundation

func solution(_ myString:String, _ pat:String) -> Int {
    
    var result = 0
    var str = myString
    
    while str.count >= pat.count{
        if str.hasPrefix(pat) {
            result += 1
        }
        str = String(str.dropFirst())
    }
    
    return result
}