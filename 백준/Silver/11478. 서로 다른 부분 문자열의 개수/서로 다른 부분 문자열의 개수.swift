let input = Array(readLine()!)
var answerSet = Set<String>()

for i in 0..<input.count {
    var s = ""
    for j in i..<input.count {
        s += String(input[j])
        answerSet.insert(s)

    }
}

print(answerSet.count)
