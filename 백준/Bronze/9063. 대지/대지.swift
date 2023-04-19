let time = Int(readLine()!)!

var minX = Int.max
var minY = Int.max
var maxX = Int.min
var maxY = Int.min


(0..<time).forEach { _ in
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (x, y) = (input[0], input[1])

    minX = min(minX, x)
    maxX = max(maxX, x)

    minY = min(minY, y)
    maxY = max(maxY, y)
}


print((maxY - minY) * (maxX - minX))

