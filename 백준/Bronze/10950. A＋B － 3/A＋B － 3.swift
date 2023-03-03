let time = Int(readLine()!)!

for i in 1...time {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    print(input[0] + input[1])
}
