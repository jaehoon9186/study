let input = readLine()!.split(separator: " ").map { Int($0)! }
let (x, y, w, h) = (input[0], input[1], input[2], input[3])

var answer = x

answer = min(answer, y)
answer = min(answer, w - x)
answer = min(answer, h - y)

print(answer)
