let input = Int(readLine()!)!
var times: [Int] = [0] + readLine()!.split(separator: " ").map { Int($0)! }.sorted()
var result = 0

for i in 1..<times.count {
    times[i] = times[i] + times[i - 1]
    result += times[i]
}

print(result)
