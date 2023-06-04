let input = readLine()!.split(separator: " ").map {  Int($0)! }
let (n, m) = (input[0], input[1])

var table: [[Int]] = Array(repeating: Array(repeating: 0, count: n + 1), count: 1)

for _ in 0..<n {
    let temp = [0] + readLine()!.split(separator: " ").map { Int($0)! }
    table.append(temp)
}

for i in 1...n {
    for j in 1...n {
        table[i][j] = table[i][j] + table[i - 1][j] + table[i][j - 1] - table[i - 1][j - 1]
    }
}

for _ in 0..<m {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let (aX, aY, bX, bY) = (temp[0] - 1, temp[1] - 1, temp[2], temp[3])
    print(table[bX][bY] - table[aX][bY] - table[bX][aY] + table[aX][aY])
}
