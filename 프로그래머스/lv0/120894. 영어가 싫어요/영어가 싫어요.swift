import Foundation

func solution(_ numbers:String) -> Int64 {
    
    let numDict: [String: String] = ["zero": "0", "one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9"]
    
    var str = numbers
    
    for i in numDict.keys {
        str = str.replacingOccurrences(of: i, with: numDict[i]!)
    }
    
    
    return Int64(str)!
}