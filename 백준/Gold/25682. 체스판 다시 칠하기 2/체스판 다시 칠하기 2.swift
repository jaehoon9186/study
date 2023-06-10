
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m, k) = (input[0], input[1], input[2])

var board: [[String]] = []
var prefixSumStartW: [[Int]] = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)
var prefixSumStartB: [[Int]] = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)

var test: [[String]] = Array(repeating: Array(repeating: "", count: m + 1), count: n + 1)

let wbList: [String] = ["W", "B"]
var toggle: Bool = false

var result: Int = Int.max


for _ in 0..<n {
    board.append(readLine()!.map { String($0) })
}

for i in 0..<board.count {
    for j in 0..<board[i].count {

        let wbIdx = toggle ? 1 : 0


        prefixSumStartW[i + 1][j + 1] = prefixSumStartW[i + 1][j] + prefixSumStartW[i][j + 1] - prefixSumStartW[i][j]

        prefixSumStartB[i + 1][j + 1] = prefixSumStartB[i + 1][j] + prefixSumStartB[i][j + 1] - prefixSumStartB[i][j]

        // start W
        if board[i][j] == wbList[wbIdx] {
            prefixSumStartW[i + 1][j + 1] += 1
        } else { // start B
            prefixSumStartB[i + 1][j + 1] += 1
        }

        test[i + 1][j + 1] = wbList[wbIdx]
        toggle.toggle()
    }
    if m % 2 == 0 {
        toggle.toggle()
    }
}


for i in k...n {
    for j in k...m {
        result = min(result, prefixSumStartW[i][j] - prefixSumStartW[i - k][j] - prefixSumStartW[i][j - k] + prefixSumStartW[i - k][j - k], prefixSumStartB[i][j] - prefixSumStartB[i - k][j] - prefixSumStartB[i][j - k] + prefixSumStartB[i - k][j - k])
    }
}
print(result)

