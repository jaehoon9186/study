import Foundation

func solution(_ myString:String, _ pat:String) -> String {
    
    let reversedMyString = Array(String(myString.reversed()))
    let reversedPat = Array(String(pat.reversed()))
    var reversedPatCheck = Array(String(pat.reversed()))
    
    var i = 0
    
    while reversedPatCheck.isEmpty == false {
        if reversedMyString[i] == reversedPatCheck[0] {
            reversedPatCheck.removeFirst()
        } else {
            reversedPatCheck = reversedPat
        }
        
        i += 1
    }
    
    return String(myString.prefix(myString.count - i + pat.count))
}