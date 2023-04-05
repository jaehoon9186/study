
var xPos: [Int: Int] = [:]
var yPos: [Int: Int] = [:]

(0..<3).forEach { _ in
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (x, y) = (input[0], input[1])
    xPos[x, default: 0] += 1
    yPos[y, default: 0] += 1
}

print(xPos.first(where: { $0.value == 1 } )!.key, yPos.first(where: { $0.value == 1 } )!.key)
