let input = readLine()!.split(separator: " ").map { Int($0)! }
let a = Set(readLine()!.split(separator: " ").map { Int($0)! })
let b = Set(readLine()!.split(separator: " ").map { Int($0)! })

print(a.subtracting(b).count + b.subtracting(a).count)

