let time = Int(readLine()!)!
var box: [[Int]] = []

let dx = [0, 0, -1, 1]
let dy = [-1, 1, 0, 0]

for _ in 0..<time {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (m, n, k) = (input[0], input[1], input[2])

    var count = 0
    box = []

    for _ in 0..<m {
        box.append(Array(repeating: 0, count: n))
    }

    for _ in 0..<k {
        let temp = readLine()!.split(separator: " ").map { Int($0)! }
        box[temp[0]][temp[1]] = 1
    }

    for i in 0..<m {
        for j in 0..<n {
            if box[i][j] == 1 {
                count += 1
                dfs(i, j, m, n)
            }
        }
    }

    print(count)
}


func dfs(_ row: Int, _ col: Int, _ maxRow: Int, _ maxCol: Int) {
    box[row][col] = 0

    for i in zip(dy, dx) {
        let (nextY, nextX) = (row + i.0, col + i.1)


        if nextY < 0 || nextY >= maxRow || nextX < 0 || nextX >= maxCol {
            continue
        }


        if box[nextY][nextX] == 1 {
            dfs(nextY, nextX, maxRow, maxCol)
        }
    }

}