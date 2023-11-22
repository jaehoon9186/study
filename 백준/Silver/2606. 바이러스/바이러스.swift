let computerCount = Int(readLine()!)!
let linkCount = Int(readLine()!)!

var graph = Array(repeating: [Int](), count: computerCount + 1)
var visited = Array(repeating: false, count: computerCount + 1)

for _ in 0..<linkCount {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let (a, b) = (temp[0], temp[1])
    graph[a].append(b)
    graph[b].append(a)
}


func dfs(_ node: Int) {
    visited[node] = true

    for i in graph[node] {
        if visited[i] == false {
            dfs(i)
        }
    }
}

dfs(1)

print(visited.filter { $0 }.count - 1)