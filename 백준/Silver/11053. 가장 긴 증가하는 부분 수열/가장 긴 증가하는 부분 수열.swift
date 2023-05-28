let input = Int(readLine()!)!
let numbers = readLine()!.split(separator: " ").map { Int($0)! }
var dpList: [Int] = Array(repeating: 0, count: input)

dpList[0] = 1

for i in 1..<input {
    var distance = 0
    for j in 0..<i {
        if numbers[j] < numbers[i] {
            distance = max(distance, dpList[j])
        }
    }
    dpList[i] = distance + 1
}

print(dpList.max()!)
