let n = Int(readLine()!)!

var box: [[Int]] = []
var visited = Array(repeating: Array(repeating: false, count: n), count: n)


// 상, 하, 좌, 우
let dx = [0, 0, -1, 1]
let dy = [-1, 1, 0, 0]

var result: [Int] = []
var count = 0

for _ in 0..<n {
    box.append(readLine()!.map { Int(String($0))! })
}


func dfs(_ row: Int, _ col: Int) {
    visited[row][col] = true
    count += 1

    for i in zip(dy, dx) {
        let (nextY, nextX) = (row + i.0, col + i.1)


        if nextY < 0 || nextY >= n || nextX < 0 || nextX >= n {
            continue
        }


        if box[nextY][nextX] == 1 && visited[nextY][nextX] == false {
            dfs(nextY, nextX)
        }
    }

}


for i in 0..<n {
    for j in 0..<n {
        if box[i][j] == 1 && visited[i][j] == false {
            dfs(i, j)
            result.append(count)
            count = 0
        }
    }
}

print(result.count)
print(result.sorted(by: <).map { String($0) }.joined(separator: "\n"))