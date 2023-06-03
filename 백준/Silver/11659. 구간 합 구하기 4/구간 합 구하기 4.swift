let input = readLine()!.split(separator: " ").map { Int($0)! }
var numbers = [0] + readLine()!.split(separator: " ").map { Int($0)! }

for i in 1..<numbers.count {
    numbers[i] = numbers[i] + numbers[i - 1]
}

for _ in 0..<input[1] {
    let section = readLine()!.split(separator: " ").map { Int($0)! }
    print(numbers[section[1]] - numbers[section[0] - 1])
}
