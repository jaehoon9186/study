import Foundation

let inputTime = Int(readLine()!)!

var primeIdx : [Bool] = []
var numberList: [Int] = []
var maxNumber = 0

for _ in (0..<inputTime) {
    let number = Int(readLine()!)!
    numberList.append(number)
}

maxNumber = numberList.max()!

primeIdx = Array(repeating: true, count: maxNumber + 1)
primeIdx[0] = false
primeIdx[1] = false

for i in (0..<Int(sqrt(Double(primeIdx.count))) + 1) {
    if primeIdx[i] == false {
        continue
    }

    for j in stride(from: i + i, to: primeIdx.count, by: i) {
        primeIdx[j] = false
    }
}

for i in numberList {
    var answer = 0
    for j in 1...i / 2 {
        if primeIdx[j] && primeIdx[i-j] {
            answer += 1
        }
    }
    print(answer)
}
