let t = Int(readLine()!)!
var triangleList: [[Int]] = []
var dpList: [[Int]] = []

for _ in 0..<t {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    triangleList.append(input)
}

dpList.append(triangleList[0])

for i in 1..<t {
    var temp: [Int] = []

    for j in triangleList[i].indices {
        if j == 0 {
            temp.append(triangleList[i][0] + dpList[i - 1][0])
            continue
        }
        if j == triangleList[i].count - 1 {
            temp.append(triangleList[i][j] + dpList[i - 1][j - 1])
            break
        }
        temp.append(max(triangleList[i][j] + dpList[i - 1][j - 1], triangleList[i][j] + dpList[i - 1][j]))
    }

    dpList.append(temp)
}


if let endList = dpList.last, let maximumSum = endList.max() {
    print(maximumSum)
}
