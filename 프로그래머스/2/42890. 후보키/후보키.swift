import Foundation

func solution(_ relation:[[String]]) -> Int {
    
    let uniqueCount = relation.count
    let allComb = comb((0..<relation[0].count).map { $0 })
    var uniqueAndMinimal: [[Int]] = []
    
    for i in allComb {
        let count = Set(relation.map { $0.enumerated().filter{ i.contains($0.offset) }.map { $0.element } }).count
        if uniqueCount > count  {
            continue
        }
        
        var isMinimal = true
        for j in uniqueAndMinimal {
            if Set(j).isSubset(of: Set(i)) {
                isMinimal = false
                break
            }
        }
        if isMinimal {
            uniqueAndMinimal.append(i)
        }
    }
    
    return uniqueAndMinimal.count
}


func comb(_ list: [Int]) -> [[Int]] {
    var result: [[Int]] = []
    
    func getComb(_ r: Int, _ output: [Int] = [], _ dept: Int = 0) {
        var output = output
        if output.count == r {
            result.append(output)
            return
        }
        for i in dept..<list.count {
            output.append(list[i])
            getComb(r, output, i+1)
            output.removeLast()
        }
    }
    
    for i in 1...list.count {
        getComb(i)
    }
    
    return result
}