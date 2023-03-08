let input = readLine()!.split(separator: " ").map { Int($0)! }
let numbers = readLine()!.split(separator: " ").map { Int($0)! }

print(numbers.filter { $0 < input[1] }.map { String($0) }.joined(separator: " "))
