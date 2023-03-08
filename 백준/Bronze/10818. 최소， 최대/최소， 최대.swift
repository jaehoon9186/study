let input = Int(readLine()!)!
let numbers = readLine()!.split(separator: " ").map { Int($0)! }

print(numbers.min()!, numbers.max()!)

