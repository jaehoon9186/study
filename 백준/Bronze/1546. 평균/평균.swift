let count = Double(readLine()!)!
let points = readLine()!.split(separator: " ").map { Double($0)! }
let maxPoint = points.max()!

print(points.map { $0/maxPoint*100 }.reduce(0) {$0 + $1}/count)
