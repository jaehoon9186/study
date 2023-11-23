let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])
var distance = Array(repeating: Array(repeating: 0, count: m), count: n)
var box: [[Int]] = []

let dx = [0, 0, -1, 1]
let dy = [-1, 1, 0, 0]

for _ in 0..<n {
    let temp = readLine()!.map { Int(String($0))! }
    box.append(temp)
}


func bfs(_ row: Int, _ col: Int) {

    var queue: [[Int]] = []

    box[row][col] = 0
    distance[row][col] = 1
    queue.append([row, col])

    while queue.isEmpty == false {
        let now = queue.removeFirst()

        for i in zip(dy, dx) {
            let (nextY, nextX) = (now[0] + i.0, now[1] + i.1)

            if nextY < 0 || nextY >= n || nextX < 0 || nextX >= m {
                continue
            }

            if box[nextY][nextX] == 1 {
                queue.append([nextY, nextX])
                box[nextY][nextX] = 0
                distance[nextY][nextX] = distance[now[0]][now[1]] + 1
            }

        }

    }

}

bfs(0, 0)

print(distance[n - 1][m - 1])