let target = Int(readLine()!)!
let time = Int(readLine()!)!
var sum = 0

for _ in 1...time {
    sum += readLine()!.split(separator: " ").map { Int($0)! }.reduce(1) { $0 * $1 }
}

print(target == sum ? "Yes" : "No")
