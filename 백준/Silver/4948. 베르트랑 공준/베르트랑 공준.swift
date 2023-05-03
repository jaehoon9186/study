var primeNumbers: [Bool] = []
var numberList: [Int] = []
var maxNumber = 0

while let input = readLine() {
    let number = Int(input)!

    if number == 0 {
        maxNumber = numberList.max()!
        break
    }

    numberList.append(number)
}

primeNumbers = Array(repeating: true, count: (maxNumber * 2) + 1)
primeNumbers[0] = false
primeNumbers[1] = false

for i in (0..<primeNumbers.count) {
    if primeNumbers[i] == false {
        continue
    }

    for j in stride(from: i + i, to: primeNumbers.count, by: i) {
        primeNumbers[j] = false
    }
}

for i in numberList {
    print(primeNumbers[i+1...i*2].filter { $0 }.count)
}
