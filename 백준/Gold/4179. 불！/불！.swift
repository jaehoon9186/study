let input = readLine()!.split(separator: " ").map { Int($0)! }
let (r, c) = (input[0], input[1])

var maze: [[Character]] = []
var distance = Array(repeating: Array(repeating: 0, count: c), count: r)
let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

var queue: [[Int]] = []
var queueIndex = 0

var resultList: [Int] = []

for _ in 0..<r {
    maze.append(Array(readLine()!))
}

for i in 0..<r {
    for j in 0..<c {
        let s = maze[i][j]
        if s == "J" {
            queue.insert([i, j], at: 0)
        }
        if s == "F" {
            queue.append([i, j])
        }
    }
}

while queueIndex < queue.count {
    let now = queue[queueIndex]
    queueIndex += 1

    for i in 0..<4 {
        let nextX = now[0] + dx[i]
        let nextY = now[1] + dy[i]

        if nextX < 0 || nextX >= r || nextY < 0 || nextY >= c {
            if maze[now[0]][now[1]] == "J" {
                resultList.append(distance[now[0]][now[1]] + 1)
            }
            continue
        }

        if maze[now[0]][now[1]] == "J" && maze[nextX][nextY] == "." {
            maze[nextX][nextY] = "J"
            distance[nextX][nextY] = distance[now[0]][now[1]] + 1
            queue.append([nextX, nextY])
        } else if maze[now[0]][now[1]] == "F" &&
                    ["J", "."].contains(maze[nextX][nextY]) {
            maze[nextX][nextY] = "F"
            queue.append([nextX, nextY])
        }
    }
}

print(resultList.isEmpty ? "IMPOSSIBLE" : resultList.min()!)
