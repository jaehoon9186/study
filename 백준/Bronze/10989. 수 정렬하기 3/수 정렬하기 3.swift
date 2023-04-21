let input = Int(readLine()!)!
var numbers = Array(repeating: 0, count: 10001)

(0..<input).forEach { _ in
    numbers[Int(readLine()!)!] += 1
}

var answer = ""
for i in numbers.indices {
    answer += String(repeating: "\(i)\n", count: numbers[i])
}
print(answer)
