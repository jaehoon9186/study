let n = Int(readLine()!)!
var paper: [[Int]] = []
var result = ""

for _ in 0..<n {
    paper.append(Array(readLine()!).map { Int(String($0))! })
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
            result += "1"
        } else {
            result += "0"
        }
    } else {
        result += "("
        let halfLenth = (rowEnd - rowStart) / 2
        start(arr, rowStart, rowEnd - halfLenth, colStart, colEnd - halfLenth)
        start(arr, rowStart, rowEnd - halfLenth, colStart + halfLenth, colEnd)
        start(arr, rowStart + halfLenth, rowEnd, colStart, colEnd - halfLenth)
        start(arr, rowStart + halfLenth, rowEnd, colStart + halfLenth, colEnd)
        result += ")"
    }

}

start(paper, 0, n, 0, n)

print(result)
