let sang = Int(readLine()!)!
let sangList = readLine()!.split(separator: " ").map { Int($0)! }
let taget = Int(readLine()!)!
let tagetList = readLine()!.split(separator: " ").map { Int($0)! }

var dict: [Int: Int] = [:]
var answer: [Int] = []

for i in sangList {
    dict[i] = 1
}

for i in tagetList {
    answer.append(dict[i] ?? 0)
}

print(answer.map { String($0) }.joined(separator: " "))
