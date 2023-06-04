let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, k) = (input[0], input[1])
var numbers = readLine()!.split(separator: " ").map { Int($0)! }

var maxResult = 0
var slideSum = 0
for i in 0..<k {
    maxResult += numbers[i]
}

slideSum = maxResult

for i in k..<n {
    slideSum = slideSum + numbers[i] - numbers[i - k]
    maxResult = max(maxResult, slideSum)
}

print(maxResult)
