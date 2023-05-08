let time = Int(readLine()!)!

var combCountArr: [[Int]] = Array(repeating: Array(repeating: 0, count: 31), count: 31)
// n의 최대값 30 까지 조합의 개수들 구해놓기
for n in 0..<31 {
    for r in 0...n {
        if n == r || r == 0 {
            combCountArr[n][r] = 1
            continue
        }

        combCountArr[n][r] = combCountArr[n - 1][r - 1] + combCountArr[n - 1][r]
    }
}


for _ in 0..<time {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (r, n) = (input[0], input[1])

    print(combCountArr[n][r])

}


