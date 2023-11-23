let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, k) = (input[0], input[1])
var distance = Array(repeating: 0, count: 100001)
var visited = Array(repeating: false, count: 100001)
var queue: [Int] = []

func bfs(_ start: Int) {
    queue.append(start)
    visited[start] = true
    distance[start] = 0
    var index = 0

    while index < queue.count {
        let now = queue[index]

        if now == k {
            return
        }

        for i in 0..<3 {
            var next = now

            switch i {
            case 0:
                next += 1
            case 1:
                next -= 1
            default:
                next *= 2
            }

            if next < 0 || next > 100000 {
                continue
            }

            if visited[next] == true {
                continue
            }

            queue.append(next)
            visited[next] = true
            distance[next] = distance[now] + 1

        }

        index += 1

    }

}

bfs(n)

print(distance[k])