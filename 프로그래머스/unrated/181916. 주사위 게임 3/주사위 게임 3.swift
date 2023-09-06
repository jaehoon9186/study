import Foundation

func solution(_ a:Int, _ b:Int, _ c:Int, _ d:Int) -> Int {
    
    var dict: [Int: Int] = [:]
    
    for i in [a, b, c, d] {
        dict[i, default: 0] += 1
    }
    
    let sortedDict = dict.sorted { $0.1 > $1.1 }

    switch sortedDict[0].value {
        case 4:
            return 1111 * sortedDict[0].key 
        case 3:
            return (10 * sortedDict[0].key + sortedDict[1].key) * (10 * sortedDict[0].key + sortedDict[1].key)
        case 2:
            if sortedDict[1].value == 2 {
                return (sortedDict[0].key + sortedDict[1].key) * abs(sortedDict[0].key - sortedDict[1].key)
            } else {
                return sortedDict[1].key * sortedDict[2].key
            }
        default:
            return min(a, b, c, d)
    }
    
    
    return 0
}