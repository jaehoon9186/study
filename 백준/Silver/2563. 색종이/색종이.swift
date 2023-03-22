let t = Int(readLine()!)!
var box = Array(repeating: Array(repeating: 0, count: 100), count: 100)
var answer = 0

for _ in (0..<t) {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (x, y) = (input[0] - 1, input[1] - 1)

    for i in (x..<(x+10)) {
        for j in (y..<(y+10)) {
            box[i][j] = 1
        }
    }
}

for i in (0..<100) {
    for j in (0..<100) {
        if box[i][j] == 1 {
            answer += 1
        }
    }
}

print(answer)



