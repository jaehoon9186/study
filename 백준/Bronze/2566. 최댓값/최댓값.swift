var numList: [[Int]] = []
var maxNum = 0
var ij = (0, 0)

for _ in (0..<9) {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    numList.append(temp)
}

for i in (0..<9) {
    for j in (0..<9) {
        if numList[i][j] >= maxNum {
            maxNum = numList[i][j]
            ij = (i + 1, j + 1)
        }
    }
}

print(maxNum)
print(ij.0, ij.1)
