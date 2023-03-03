let t = Int(readLine()!)!

for i in 1...t {
    print("Case #\(i):", readLine()!.split(separator: " ").map { Int($0)! }.reduce(0, +))
}
