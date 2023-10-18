import Foundation

func solution(_ s:String) -> Int {
    
    let numDic: [String: String] = [
        "zero":"0",
        "one":"1",
        "two":"2",
        "three":"3",
        "four":"4",
        "five":"5",
        "six":"6",
        "seven":"7",
        "eight":"8",
        "nine":"9",
    ]
    var result = s
    
    for i in numDic.keys {
        result = result.replacingOccurrences(of: i, with: numDic[i]!)
    }
    
    return Int(result)!
}