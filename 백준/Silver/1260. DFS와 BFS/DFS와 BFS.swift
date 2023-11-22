let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m, v) = (input[0], input[1], input[2])

var graph = Array(repeating: Array<Int>() , count: n + 1)
var visited = Array(repeating: false, count: n + 1)
var dfsResult = Array<Int>()
var bfsResult = Array<Int>()

for _ in 0..<m {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let (a, b) = (temp[0], temp[1])
    graph[a].append(b)
    graph[b].append(a)
}

func dfs(_ node: Int) {
    visited[node] = true
    dfsResult.append(node)

    for i in graph[node].sorted(by: <) {
        if visited[i] == false {
            dfs(i)
        }
    }
}

func bfs(_ node: Int) {
    visited[node] = true

    var q = Array<Int>()
    var index = 0
    q.append(node)

    while index < q.count {
        let nowNode = q[index]
        bfsResult.append(nowNode)

        for i in graph[nowNode].sorted(by: <) {
            if visited[i] == false {
                visited[i] = true
                q.append(i)
            }
        }

        index += 1
    }
}


dfs(v)
visited = visited.map { _ in false }
bfs(v)

print(dfsResult.map { String($0) }.joined(separator: " "))
print(bfsResult.map { String($0) }.joined(separator: " "))