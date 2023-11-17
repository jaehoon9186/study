import Foundation

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
    var visited = Array(repeating: false, count: words.count)
    var result = Int.max
    
    
    func dfs(_ depth: Int, _ index: Int) {
        if target == words[index] {
            result = min(result, depth)
            return
        }
        
        for i in 0..<words.count {
            if visited[i] == false && diffCount(words[i], words[index]) <= 1 {
                visited[i] = true
                dfs(depth + 1, i)
                visited[i] = false
            }
        }
    }
    
    for i in 0..<words.count {
        if diffCount(begin, words[i]) <= 1 {
            visited[i] = true
            dfs(1, i)
            visited[i] = false
        }
    }
    
    return result == Int.max ? 0 : result
}

func diffCount(_ first: String, _ second: String) -> Int {
    
    var count = 0
    
    for i in zip(first, second) {
        if i.0 != i.1 {
            count += 1
        }
    }
    
    return count
}