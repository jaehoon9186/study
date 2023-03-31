import Foundation

let input = Int(readLine()!)!

// 제곱
func power(_ number: Int, _ time: Int) -> Int {
    var po = 1
    (0..<time).forEach { _ in
        po *= number
    }
    return po
}

// 사각형의 한쪽 면 사이즈
let n = Int(sqrt(Double(power(4, input))))

// 점의 개수
print(power(n, 2) + 2 * n + 1)

