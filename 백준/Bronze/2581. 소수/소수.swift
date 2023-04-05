import Foundation

let m = Int(readLine()!)!
let n = Int(readLine()!)!
var primeList: [Int] = []

func isPrime(_ number: Int) -> Bool {
    if number <= 1 {
        return false
    }

    for i in 2..<Int(sqrt(Double(number))) + 1 {
        if number % i == 0 {
            return false
        }
    }

    return true
}

(m...n).forEach { i in
    if isPrime(i) {
        primeList.append(i)
    }
}

if primeList.isEmpty {
    print(-1)
} else {
    print(primeList.reduce(0) { $0 + $1 })
    print(primeList[0])
}
