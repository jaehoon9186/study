let t = Int(readLine()!)!

var distance: [[Int]] = []
var visited: [[Bool]] = []
var queue: [[Int]] = []

let dy = [-2, -2, 2, 2, -1, 1, -1, 1]
let dx = [-1, 1, -1, 1, -2, -2, 2, 2]

for _ in 0..<t {
    let l = Int(readLine()!)!
    let start = readLine()!.split(separator: " ").map { Int($0)! }
    let target = readLine()!.split(separator: " ").map { Int($0)! }

    distance = []
    visited = []
    queue = []

    for _ in 0..<l {
        distance.append(Array(repeating: 0, count: l))
        visited.append(Array(repeating: false, count: l))
    }

    bfs(start[0], start[1], l, target)

    print(distance[target[0]][target[1]])
}


func bfs(_ row: Int, _ col: Int, _ maxLen: Int, _ target: [Int]) {

    visited[row][col] = true
    distance[row][col] = 0
    queue.append([row, col])

    var index = 0

    while index < queue.count {
        let now = queue[index]
        if now == target { return }

        for i in zip(dy, dx) {
            let (nextY, nextX) = (now[0] + i.0, now[1] + i.1)

            if nextY < 0 || nextY >= maxLen || nextX < 0 || nextX >= maxLen { continue }

            if visited[nextY][nextX] == false {
                queue.append([nextY, nextX])
                visited[nextY][nextX] = true
                distance[nextY][nextX] = distance[now[0]][now[1]] + 1
            }
        }
        index += 1
    }

}