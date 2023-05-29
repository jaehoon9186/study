let input = Int(readLine()!)!
let numbers = readLine()!.split(separator: " ").map { Int($0)! }
let reversedNumbers = Array(numbers.reversed())
var dpToTop = Array(repeating: 1,count: input)
var dpToDown = Array(repeating: 1,count: input)


// toTop
for i in 1..<input {
    for j in 0..<i {
        if numbers[i] > numbers[j] {
            dpToTop[i] = max(dpToTop[j] + 1, dpToTop[i])
        }

        if reversedNumbers[i] > reversedNumbers[j] {
            dpToDown[i] = max(dpToDown[j] + 1, dpToDown[i])
        }
    }
}

dpToDown.reverse()

var maxbi = 0
for i in 0..<input {
    maxbi = max(maxbi, dpToTop[i] + dpToDown[i] - 1)
}


print(maxbi)
