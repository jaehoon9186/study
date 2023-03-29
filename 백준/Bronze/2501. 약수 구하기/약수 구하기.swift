let input = readLine()!.split(separator: " ").map { Int($0)! }
let (a, b) = (input[0], input[1])
var count = 0
var answer = 0

for i in (1...a) {
    if a % i == 0 {
        count += 1
    }
    if count == b {
        answer = i
        break
    }
}

print(answer)
