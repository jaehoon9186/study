let t = Int(readLine()!)!
let input = readLine()!.split(separator: " ").map { Int($0)! }
var dp = Array(repeating: 0, count: t)

dp[0] = input[0]

for i in 1..<t {
    dp[i] = max(dp[i - 1] + input[i], input[i])
}

print(dp.max()!)
