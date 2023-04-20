let input = readLine()!.split(separator: " ").map { Int($0)! }
let (row, column) = (input[0], input[1])
var board: [[Character]] = []

var checkStartW: [[Int]] = []
var checkStartB: [[Int]] = []

let wbList: [Character] = ["W", "B"]
var toggle: Bool = false

var answer = Int.max

(0..<row).forEach { _ in
    board.append(Array(readLine()!))
}

for i in (0..<row) {
    var checkStartWSub: [Int] = []
    var checkStartBSub: [Int] = []

    for j in (0..<column) {
        let wbIdx = toggle ? 1 : 0

        if board[i][j] == wbList[wbIdx] {
            checkStartWSub.append(0)
            checkStartBSub.append(1)
        } else {
            checkStartWSub.append(1)
            checkStartBSub.append(0)
        }

        toggle.toggle()
    }

    checkStartW.append(checkStartWSub)
    checkStartB.append(checkStartBSub)

    // 짝수인경우 wbwb bwbw
    if column % 2 == 0 {
        toggle.toggle()
    }
}




for i in (0..<row) {
    for j in (0..<column) {
        if i > 0 {
            checkStartW[i][j] += checkStartW[i - 1][j]
            checkStartB[i][j] += checkStartB[i - 1][j]
        }
        if j > 0 {
            checkStartW[i][j] += checkStartW[i][j - 1]
            checkStartB[i][j] += checkStartB[i][j - 1]

        }
        if i > 0 && j > 0 {
            checkStartW[i][j] -= checkStartW[i - 1][j - 1]
            checkStartB[i][j] -= checkStartB[i - 1][j - 1]
        }
    }
}

for i in (7..<row) {
    for j in (7..<column) {
        var startWSum = checkStartW[i][j]
        var startBSum = checkStartB[i][j]

        if i > 7 {
            startWSum -= checkStartW[i - 8][j]
            startBSum -= checkStartB[i - 8][j]
        }
        if j > 7 {
            startWSum -= checkStartW[i][j - 8]
            startBSum -= checkStartB[i][j - 8]

        }
        if i > 7 && j > 7 {
            startWSum += checkStartW[i - 8][j - 8]
            startBSum += checkStartB[i - 8][j - 8]
        }

        answer = min(answer, startWSum, startBSum)
    }
}

print(answer)
