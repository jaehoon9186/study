import Foundation

let t = readLine()
let input = readLine()!.split(separator: " ").map { Int($0)! }
var count = 0

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

input.enumerated().forEach { (i, v) in
    if isPrime(v) {
        count += 1
    }
}

print(count)
