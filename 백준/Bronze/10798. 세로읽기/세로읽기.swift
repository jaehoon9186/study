var charList: [[Character]] = []
var listSize = 0
var answer = ""

for _ in (0..<5) {
    let temp = Array(readLine()!)
    listSize = max(listSize, temp.count)
    charList.append(temp)
}

for j in (0..<listSize) {
    for i in (0..<5) {
        if j < charList[i].count {
            answer += String(charList[i][j])
        }
    }
}

print(answer)
