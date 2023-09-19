import Foundation

func solution(_ arr:[Int], _ k:Int) -> [Int] {
    
    var uniqueList: [Int] = []
    var uniqueSet = Set<Int>()
    var result: [Int] = []
    let listUniqueCount = Set(arr).count
    
    for i in arr {
        if listUniqueCount == uniqueSet.count {
            break
        }
        
        if uniqueSet.contains(i) == false {
            uniqueList.append(i)
            uniqueSet.insert(i)
        }
    }
    
    for _ in (0..<k) {
        if uniqueList.isEmpty {
            result.append(-1)
            continue
        }
        
        result.append(uniqueList.removeFirst())
    }
    
    return result
}