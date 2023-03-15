import Foundation

let allInput = Int(readLine()!)!

for _ in (0..<allInput) {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (count, point) = (input[0], input[1...])
    let avg = Double(point.reduce(0, +)) / Double(count)
    let overAvg = point.filter { Double($0) > avg }

    let answer = String(format: "%.3f", Float(overAvg.count) / Float(point.count) * 100)
    print(answer, "%", separator: "")

}

