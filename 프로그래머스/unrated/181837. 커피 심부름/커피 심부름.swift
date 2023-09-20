import Foundation

func solution(_ order:[String]) -> Int {
    var result = 0
    
    for i in order {
        if i.contains("cafelatte") {
            result += 5000
        } else {
            result += 4500
        }
    }
    
    return result
}