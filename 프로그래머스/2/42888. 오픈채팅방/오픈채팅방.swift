import Foundation

func solution(_ record:[String]) -> [String] {
    
    var name: [String: String] = [:]
    var result: [[String]] = []
    
    for i in record {
        let temp = i.split(separator: " ").map { String($0) }
        
        if temp[0] == "Enter" {
            result.append([temp[1], "님이 들어왔습니다."])
            name[temp[1]] = temp[2]
        } else if temp[0] == "Leave" {
            result.append([temp[1], "님이 나갔습니다."])
        } else if temp[0] == "Change" {
            name[temp[1]] = temp[2]
        }
    }
    
    return result.map { name[$0[0]]! + $0[1] }
}