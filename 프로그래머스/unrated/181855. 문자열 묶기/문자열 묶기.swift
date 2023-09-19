import Foundation

func solution(_ strArr:[String]) -> Int {
    
    var dict: [Int: [String]] = [:]
    
    for i in strArr {
        dict[i.count, default: []].append(i)
    }

    return dict.sorted { $0.1.count > $1.1.count }[0].value.count
}