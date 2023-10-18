import Foundation

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    
    var reportDict: [String: [String]] = [:]
    var suspendedDict: [String: Int] = [:]
    
    for i in Set(report) {
        let temp = i.split(separator: " ").map { String($0) }
        reportDict[temp[0], default: []].append(temp[1])
        suspendedDict[temp[1], default: 0] += 1
    }
    
    
    return id_list.map { reportDict[$0, default: []].filter { s in suspendedDict[s, default: 0] >= k }.count }
} 