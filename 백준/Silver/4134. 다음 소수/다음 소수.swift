import Foundation

let input = Int(readLine()!)!
var list: [Int] = []

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

for _ in (0..<input) {
    list.append(Int(readLine()!)!)
}

for i in list {

    var tmp = i

    while !isPrime(tmp) {
        tmp += 1
    }

    print(tmp)
}


