let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])
let numbers = readLine()!.split(separator: " ").map { Int($0)! }
var prefixSum: [Int] = Array(repeating: 0, count: n)
var result = 0

prefixSum[0] = numbers[0]

for i in 1..<n {
    prefixSum[i] = numbers[i] + prefixSum[i - 1]
}

for i in 0..<n {
    prefixSum[i] = prefixSum[i] % m
}


var tempDict: [Int: Int] = [:]

for i in prefixSum {
    tempDict[i, default: 0] += 1
}

result += tempDict[0, default: 0]

for v in tempDict.values {
    result += v * (v - 1) / 2
}

print(result)
