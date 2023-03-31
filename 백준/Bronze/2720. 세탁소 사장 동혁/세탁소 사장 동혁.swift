let time = Int(readLine()!)!
let change = [25, 10, 5, 1]

for _ in (0..<time) {
    var money = Int(readLine()!)!
    var answer: [Int] = []
    for i in change {
        answer.append(money / i)
        money = money % i
    }
    print(answer.map { String($0) }.joined(separator: " "))
}
