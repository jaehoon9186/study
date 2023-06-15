let input1 = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input1[0], input1[1])
var mat1: [[Int]] = []

for _ in 0..<n {
    mat1.append(readLine()!.split(separator: " ").map { Int($0)! })
}

let input2 = readLine()!.split(separator: " ").map { Int($0)! }
let k = input2[1]
var mat2: [[Int]] = []

for _ in 0..<m {
    mat2.append(readLine()!.split(separator: " ").map { Int($0)! })
}

var result: [[Int]] = Array(repeating: Array(repeating: 0, count: k), count: n)

for i in 0..<n {
    for j in 0..<k {
        for p in 0..<m {
            result[i][j] += mat1[i][p] * mat2[p][j]
        }
    }
}


for i in result {
    print(i.map { String($0) }.joined(separator: " ") )
}
