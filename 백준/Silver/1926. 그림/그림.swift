let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

var box: [[Int]] = []
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: m), count: n)
var dx = [-1, 1, 0, 0]
var dy = [0, 0, -1, 1]
var stack: [[Int]] = []
var paintCount = 0
var maxPaintSize = 0

for _ in 0..<n {
    box.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for i in 0..<n {
    for j in 0..<m where visited[i][j] == false && box[i][j] == 1 {
        paintCount += 1
        visited[i][j] = true
        var paintSize = 1

        stack.append([i, j])

        while let last = stack.popLast() {
            for k in 0..<4 {
                let nextX = last[0] + dx[k]
                let nextY = last[1] + dy[k]
                if nextX < 0 || nextX >= n || nextY < 0 || nextY >= m {
                    continue
                }
                if visited[nextX][nextY] == true || box[nextX][nextY] == 0 {
                    continue
                }
                stack.append([nextX, nextY])
                visited[nextX][nextY] = true
                paintSize += 1
            }
        }

        maxPaintSize = max(maxPaintSize, paintSize)
    }
}

print(paintCount)
print(maxPaintSize)