let t = Int(readLine()!)!
var line: [Int] = Array(repeating: 0, count: 501)

for _ in 0..<t {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    line[input[0]] = input[1]
}


line = line.filter({ $0 != 0 })
var lcs = Array(repeating: 1, count: line.count)

for i in 1..<line.count {
    for j in 0..<i {
        if line[i] > line[j] {
            lcs[i] = max(lcs[i], lcs[j] + 1)
        }
    }
}

print(line.count - lcs.max()!)
