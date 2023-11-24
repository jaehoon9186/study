let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

var edges: [(Int, Int, Int)] = []

let INF = Int.max / 2
var distance: [Int] = Array(repeating: INF, count: n + 1)
distance[1] = 0

for _ in 0..<m {
    let uvw = readLine()!.split(separator: " ").map { Int($0)! }
    edges.append((uvw[0], uvw[1], uvw[2]))
}

func bellmanFord() -> Bool {

    for _ in 0..<(n-1) {
        for e in edges {
            relax(u: e.0, v: e.1, w: e.2)
        }
    }

    for e in edges {
        let (u, v, w) = (e.0, e.1, e.2)
        if distance[u] == INF {
            continue
        }

        if distance[v] > distance[u] + w {
            return false
        }
    }


    return true
}

func relax(u: Int, v: Int, w: Int) {
    if distance[u] == INF {
        return
    }

    if distance[v] > distance[u] + w {
        distance[v] = distance[u] + w
    }
}

if bellmanFord() == false {
    print("-1")
} else {
    print(distance[2...].map { $0 == INF ? "-1" : String($0) }.joined(separator: "\n") )
}
