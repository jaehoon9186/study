let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, b) = (input[0], input[1])
var matrix: [[Int]] = []

for _ in 0..<n {
    matrix.append(readLine()!.split(separator: " ").map { Int($0)! % 1000 })
}


func power(_ m: [[Int]], _ p: Int) -> [[Int]] {
    if p <= 1 {
        return m
    }

    if p % 2 == 1 {
        return matrixTimes(m, power(m, p - 1))
    } else {
        let half = power(m, p / 2)
        return matrixTimes(half, half)
    }
}

func matrixTimes(_ matA: [[Int]], _ matB: [[Int]]) -> [[Int]] {
    let len = matA.count
    var times: [[Int]] = Array(repeating: Array(repeating: 0, count: len), count: len)

    for i in 0..<len {
        for j in 0..<len {
            for k in 0..<len {
                times[i][j] += matA[i][k] * matB[k][j]
                times[i][j] %= 1000
            }
        }
    }

    return times
}

for i in power(matrix, b) {
    print(i.map { String($0) }.joined(separator: " "))
}
