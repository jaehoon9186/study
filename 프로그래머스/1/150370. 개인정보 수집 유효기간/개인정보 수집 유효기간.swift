import Foundation

func solution(_ today:String, _ terms:[String], _ privacies:[String]) -> [Int] {
    
    var result: [Int] = []
    var todaytemp = today.split(separator: ".").map { Int($0)! }
    todaytemp[0] -= 1
    todaytemp[1] -= 1
    var todayCount = zip([12*28, 28, 1], todaytemp).map { $0 * $1 }.reduce(0, +)
    var termsDict: [String: Int] = [:]
    
    for i in terms {
        let temp = i.split(separator: " ").map { String($0) }
        termsDict[temp[0], default: 0] = Int(temp[1])! * 28
    }
    
    for i in 0..<privacies.count {
        let temp = privacies[i].split(separator: " ").map { String($0) }
        var dateTemp = temp[0].split(separator: ".").map { Int($0)! }
        dateTemp[0] -= 1
        dateTemp[1] -= 1
        let date = zip([12*28, 28, 1], dateTemp).map { $0 * $1 }.reduce(0, +) + termsDict[temp[1]]!
        if todayCount >= date {
            result.append(i + 1)
        }
    }
    
    
    return result
}