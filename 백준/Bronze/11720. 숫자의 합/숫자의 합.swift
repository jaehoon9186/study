let count = Int(readLine()!)!
let number = readLine()!
var answer = 0

number.forEach {
    answer += Int(String($0))!
}

print(answer)
