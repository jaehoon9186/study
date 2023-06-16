let input = Int(readLine()!)!

func fibonacci(_ n: Int) -> Int {
    let base = [[1, 1], [1, 0]]

    func multiplication(_ a: [[Int]], _ b: [[Int]]) -> [[Int]] {
        var result = [[0, 0], [0, 0]]

        for i in 0..<2 {
            for j in 0..<2 {
                for k in 0..<2 {
                    result[i][j] += a[i][k] * b[k][j]
                }
                result[i][j] %= 1_000_000_007
            }
        }
        return result
    }

    func power(_ a: [[Int]], _ n: Int) -> [[Int]] {
        if n == 1 {
            return a
        }

        if n % 2 == 0 {
            let half = power(a, n / 2)
            return multiplication(half, half)
        } else {
            return multiplication(a, power(a, n - 1))
        }
    }

    return power(base, n)[0][1]
}

print(fibonacci(input))
