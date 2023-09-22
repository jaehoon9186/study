import Foundation

func solution(_ my_string:String) -> Int {
    let temp = my_string.split(separator: " ")
    
    var result = Int(temp[0])!
    
    for (i, v) in temp.enumerated() {
        if ["+", "-"].contains(v) {
            switch v {
                case "+":
                    result += Int(temp[i + 1])!
                default:
                    result -= Int(temp[i + 1])!
            }
        }
    }
    
    return result
}