import Foundation

func solution(_ s:String) -> Int {
    
    let sList = s.split(separator: " ").map { String($0) }
    
    var result = 0
    
    for i in 0..<sList.count {
        if let a = Int(sList[i]) {
            if i == sList.count - 1 || sList[i + 1] != "Z" {
                result += a
            }
        }
    }
    
    
    
    return result
}