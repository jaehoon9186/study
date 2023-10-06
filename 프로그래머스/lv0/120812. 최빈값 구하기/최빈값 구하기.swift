import Foundation

func solution(_ array:[Int]) -> Int {
    
    var dict: [Int: Int] = [:]
    
    for i in array {
        dict[i, default: 0] += 1
    }
    
    var sortedDict = dict.sorted { $0.1 > $1.1 }
    let count = sortedDict[0].value
    sortedDict = sortedDict.filter { $0.1 == count }

    
    return sortedDict.count > 1 ? -1 : sortedDict[0].key
}