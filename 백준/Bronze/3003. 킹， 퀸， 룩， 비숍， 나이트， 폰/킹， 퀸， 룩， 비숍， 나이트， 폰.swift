let chess = [1, 1, 2, 2, 2, 8]
let input = readLine()!.split(separator: " ").map { Int($0)! }
var answer: [Int] = []

(0..<chess.count).forEach {
    answer.append(chess[$0] - input[$0])
}

print(answer.map{ String($0) }.joined(separator: " "))
