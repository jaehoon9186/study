import Foundation

func solution(_ babbling:[String]) -> Int {
    
    let list: [String] = ["aya", "ye", "woo", "ma"]
    var result = 0
    let allList = getAllPermList(list)
    
    for i in babbling {
        if allList.contains(i) {
            result += 1
        }
    }
    
    
    return result
}

func getAllPermList(_ input: [String]) -> [String] {
    var result: [String] = [] 
    
    var visited: [Bool] = Array(repeating: false, count: input.count)
    
    func dfsPerm(_ list: [String], _ r: Int, _ visited: inout [Bool], _ output: [String] = []) {
        var output = output
        // 종료 조건
        if output.count >= r {
            result.append(output.joined())
            return
        }
        
        // 재귀
        for i in 0..<list.count {
            if visited[i] == false {
                visited[i] = true
                output.append(list[i])
                dfsPerm(list, r, &visited, output)
                output.removeLast()
                visited[i] = false
            }
        }
        
    }
    
    for i in 1...4 {
        dfsPerm(input, i, &visited)
    }
    
    return result
}