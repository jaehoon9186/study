let input = Int(readLine()!)!
var answer = 0

for i in (1..<input) {
    var sum = i
    var temp = i
    while temp > 0 {
        let subNum = temp % 10
        temp /= 10
        sum += subNum
    }

    if sum == input {
        answer = i
        break
    }

}

print(answer)
