let n = Int(readLine()!)!
var paper: [[Int]] = []
var whiteCount = 0
var blueCount = 0

for _ in 0..<n {
    paper.append(readLine()!.split(separator: " ").map { Int($0)! })
}


func colorCheck(_ arr: [[Int]], _ rowStart: Int, _ rowEnd: Int, _ colStart: Int, _ colEnd: Int) -> Bool {

    let checkColor = arr[rowStart][colStart]

    for i in rowStart..<rowEnd {
        for j in colStart..<colEnd {
            if checkColor != arr[i][j] {
                return false
            }
        }
    }

    return true
}

func start(_ arr: [[Int]], _ rowStart: Int, _ rowEnd: Int, _ colStart: Int, _ colEnd: Int) {

    if colorCheck(arr, rowStart, rowEnd, colStart, colEnd) {
        let checkColor = arr[rowStart][colStart]
        if checkColor == 1 {
            blueCount += 1
        } else {
            whiteCount += 1
        }
    } else {
        let halfLenth = (rowEnd - rowStart) / 2
        start(arr, rowStart, rowEnd - halfLenth, colStart, colEnd - halfLenth)
        start(arr, rowStart, rowEnd - halfLenth, colStart + halfLenth, colEnd)
        start(arr, rowStart + halfLenth, rowEnd, colStart + halfLenth, colEnd)
        start(arr, rowStart + halfLenth, rowEnd, colStart, colEnd - halfLenth)
    }

}

start(paper, 0, n, 0, n)

print(whiteCount)
print(blueCount)
