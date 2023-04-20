let input = readLine()!.split(separator: " ").map { Int($0)! }
let (size, taget) = (input[0], input[1])
let cardList = readLine()!.split(separator: " ").map { Int($0)! }

var sum = 0

for i in (0..<size-2) {
    for j in (i+1..<size-1) {
        for k in (j+1..<size) {
            let temp = cardList[i] + cardList[j] + cardList[k]
            if temp <= taget && temp > sum {
                sum = temp
            }
        }
    }
}


print(sum)
