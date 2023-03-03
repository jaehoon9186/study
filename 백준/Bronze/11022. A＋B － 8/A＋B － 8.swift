let t = Int(readLine()!)!

for i in 1...t {
    let numbers = readLine()!.split(separator: " ").map { Int($0)! }
    print("Case #\(i): \(numbers[0]) + \(numbers[1]) = \(numbers[0] + numbers[1])")
}
