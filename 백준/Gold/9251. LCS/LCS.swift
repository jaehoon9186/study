let strFirst: [String] = readLine()!.map { String($0) }
let strSecond: [String] = readLine()!.map { String($0) }

var dpTable: [[Int]] = Array(repeating: Array(repeating: 0, count: strSecond.count + 1), count: strFirst.count + 1)

for i in 1...strFirst.count {
    for j in 1...strSecond.count {
        if strFirst[i - 1] == strSecond[j - 1] {
            dpTable[i][j] = dpTable[i - 1][j - 1] + 1
        } else {
            dpTable[i][j] = max(dpTable[i - 1][j], dpTable[i][j - 1])
        }
    }
}

print(dpTable[strFirst.count][strSecond.count])
