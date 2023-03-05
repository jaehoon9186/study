let count = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int($0)! }
let target = Int(readLine()!)!
var answer = 0

arr.forEach {
    if $0 == target {
        answer += 1
    }
}

print(answer)
