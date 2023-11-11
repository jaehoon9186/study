import Foundation


func solution(_ orders:[String], _ course:[Int]) -> [String] {
    
    var temp: [[String]] = [[]]
    var allCombCount: [String: Int] = [:]
    var maxLenth: [Int] = Array(repeating: 0, count: 11)
    var result: [String] = []
    
    for i in orders {
        temp.append(getComb(String(i.sorted())))
    }
    
    for i in (temp.flatMap { $0 }) {
        allCombCount[i, default: 0] += 1
    }
    
    allCombCount.forEach { 
        let length = $0.key.count
        maxLenth[length] = max(maxLenth[length], $0.value)
    }
    
    allCombCount.forEach {
        let length = $0.key.count
        if course.contains(length) && $0.value == maxLenth[length] && maxLenth[length] >= 2 {
            result.append($0.key)
        }
    }

    
    return result.sorted()
}

func getComb(_ str: String) -> [String] {
    var combList: [String] = []
    
    func comb(_ list: [String], _ r : Int, _ dept: Int, _ output: [String] = []) {
        var output = output
        
        if output.count >= r {
            combList.append(output.joined())
            return
        }
        
        for i in dept..<list.count {
            output.append(list[i])
            comb(list, r, i + 1, output)
            output.removeLast()
        }
    }
    
    let list = str.map { String($0) }
    
    for i in 2...list.count {
        comb(list, i, 0)
    }
    
    return combList
}