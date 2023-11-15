import Foundation

func solution(_ n:Int, _ k:Int) -> Int {
    
    var dict: [Int: Int] = [:]
    let numbers = String(n, radix: k).split(separator: "0").map { Int($0)! }
    var result = 0
    
    for i in numbers {
        dict[i, default: 0] += 1
    }
    
    for i in dict {
        if isPrime(i.key) {
            result += i.value
        }
    }
    
    
    return result
}

func isPrime(_ num: Int) -> Bool {
    if num <= 1 { 
        return false
    }
    
    for i in 2..<(Int(sqrt(Double(num))) + 1) {
        if num % i == 0 { 
            return false
        }
    }
    
    return true
}