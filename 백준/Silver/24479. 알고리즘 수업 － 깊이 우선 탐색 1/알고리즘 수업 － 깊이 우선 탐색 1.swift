let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m, startNode) = (input[0], input[1], input[2])

var graph = Array(repeating: [Int](), count: n + 1)
var visited = Array(repeating: false, count: n + 1)
var visitedDepth = Array(repeating: 0, count: n + 1)

for _ in 0..<m {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let (u, v) = (temp[0], temp[1])
    graph[u].append(v)
    graph[v].append(u)
}


var depth = 1

func dfs(_ node: Int) {
    visited[node] = true
    visitedDepth[node] = depth

    for nextNode in graph[node].sorted(by: <) {
        if visited[nextNode] == false {
            depth += 1
            dfs(nextNode)
        }

    }
}

dfs(startNode)

print(visitedDepth[1...].map { String($0) }.joined(separator: "\n"))