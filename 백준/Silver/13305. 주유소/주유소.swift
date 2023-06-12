
let input = Int(readLine()!)!

let roads = readLine()!.split(separator: " ").map { Int($0)! }
let gasCosts = readLine()!.split(separator: " ").map { Int($0)! }

var gasCostMin = Int.max
var result = 0

for i in 0..<roads.count {
    gasCostMin = min(gasCostMin, gasCosts[i])

    result += gasCostMin * roads[i]
}

print(result)
