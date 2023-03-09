let input = readLine()!.split(separator: " ").map { Int($0)! }
let (count, t) = (input[0], input[1])
var numbers = Array<Int>(1...count)

(0..<t).forEach { _ in
    let changes = readLine()!.split(separator: " ").map { Int($0)! }
    numbers.swapAt(changes[0] - 1, changes[1] - 1)
}

print(numbers.map { String($0) }.joined(separator: " "))
