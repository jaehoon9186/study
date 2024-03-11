
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

var box: [[Int]] = []
var dx = [0, 0, 1, -1]
var dy = [1, -1, 0, 0]
var stack: [[Int]] = []

var distance = Array(repeating: Array(repeating: 0, count: m), count: n)

for _ in 0..<n {
    box.append(readLine()!.map { Int(String($0))! } )
}

// bfs

stack.append([0, 0])
distance[0][0] = 1

while !stack.isEmpty {
    let last = stack.removeFirst()
    for i in 0..<4 {
        let nextX = last[0] + dx[i]
        let nextY = last[1] + dy[i]

        if nextX < 0 || nextX >= n || nextY < 0 || nextY >= m {
            continue
        }

        if box[nextX][nextY] == 0 || distance[nextX][nextY] != 0  {
            continue
        }

        stack.append([nextX, nextY])
        distance[nextX][nextY] = distance[last[0]][last[1]] + 1
    }
}


print(distance[n-1][m-1])
