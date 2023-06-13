let n = Int(readLine()!)!
var paper: [[Int]] = []
var zero = 0
var minusOne = 0
var one = 0

for _ in 0..<n {
    paper.append(readLine()!.split(separator: " ").map { Int($0)! })
}


func numCheck(_ arr: [[Int]], _ rowStart: Int, _ rowEnd: Int, _ colStart: Int, _ colEnd: Int) -> Bool {

    let checkNum = arr[rowStart][colStart]

    for i in rowStart..<rowEnd {
        for j in colStart..<colEnd {
            if checkNum != arr[i][j] {
                return false
            }
        }
    }
    return true
}

func start(_ arr: [[Int]], _ rowStart: Int, _ rowEnd: Int, _ colStart: Int, _ colEnd: Int) {

    if numCheck(arr, rowStart, rowEnd, colStart, colEnd) {
        let checkNum = arr[rowStart][colStart]
        if checkNum == 0 {
            zero += 1
        } else if checkNum == 1 {
            one += 1
        } else {
            minusOne += 1
        }

    } else {
        let thirdLenth = (rowEnd - rowStart) / 3

        start(arr, rowStart, rowEnd - thirdLenth * 2,
              colStart, colEnd - thirdLenth * 2)
        start(arr, rowStart, rowEnd - thirdLenth * 2,
              colStart + thirdLenth, colEnd - thirdLenth)
        start(arr, rowStart, rowEnd - thirdLenth * 2,
              colStart + thirdLenth * 2, colEnd)

        start(arr, rowStart + thirdLenth, rowEnd - thirdLenth,
              colStart, colEnd - thirdLenth * 2)
        start(arr, rowStart + thirdLenth, rowEnd - thirdLenth,
              colStart + thirdLenth, colEnd - thirdLenth)
        start(arr, rowStart + thirdLenth, rowEnd - thirdLenth,
              colStart + thirdLenth * 2, colEnd)

        start(arr, rowStart + thirdLenth * 2, rowEnd,
              colStart, colEnd - thirdLenth * 2)
        start(arr, rowStart + thirdLenth * 2, rowEnd,
              colStart + thirdLenth, colEnd - thirdLenth)
        start(arr, rowStart + thirdLenth * 2, rowEnd,
              colStart + thirdLenth * 2, colEnd)

    }

}

start(paper, 0, n, 0, n)
print(minusOne)
print(zero)
print(one)



