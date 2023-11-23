let n = Int(readLine()!)!
let m = Int(readLine()!)!

var graph = Array(repeating: Array(repeating: Int.max / 2, count: n + 1), count: n + 1)

for i in 1...n {
    graph[i][i] = 0
}

for _ in 0..<m {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let (a, b, c) = (temp[0], temp[1], temp[2])

    graph[a][b] = min(graph[a][b], c)
}


for k in 1...n {
    for i in 1...n {
        for j in 1...n {
            if k == i || k == j || i == j {
                continue
            }

            graph[i][j] = min(graph[i][j], graph[i][k] + graph[k][j])
        }
    }
}

for i in 1..<graph.count {
    print(graph[i][1...].map { $0 >= (Int.max / 2) ? "0" : String($0) }.joined(separator: " "))
}