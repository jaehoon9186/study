let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m, startNode) = (input[0], input[1], input[2])

var graph = Array(repeating: [Int](), count: n + 1)
var visited = Array(repeating: false, count: n + 1)
var visitedDepth = Array(repeating: 0, count: n + 1)
var queue: [Int] = []

for _ in 0..<m {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let (u, v) = (temp[0], temp[1])
    graph[u].append(v)
    graph[v].append(u)
}


var depth = 0

func bfs(_ node: Int) {

    visited[node] = true
    queue.append(node)

    var index = 0

    while index < queue.count {
        let nowNode = queue[index]
        depth += 1
        visitedDepth[nowNode] = depth

        for i in graph[nowNode].sorted(by: <) {
            if visited[i] == false {
                visited[i] = true
                queue.append(i)
            }
        }

        index += 1
    }

}

bfs(startNode)

print(visitedDepth[1...].map { String($0) }.joined(separator: "\n"))