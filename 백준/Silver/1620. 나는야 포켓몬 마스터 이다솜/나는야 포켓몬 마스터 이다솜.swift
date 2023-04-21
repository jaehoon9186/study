
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (dogamCount, qCount) = (input[0], input[1])
var dogamString: [String:Int] = [:]
var dogamNumber: [Int:String] = [:]

(0..<dogamCount).forEach { i in
    let poket = readLine()!
    dogamString[poket] = i + 1
    dogamNumber[i + 1] = poket
}

(0..<qCount).forEach { _ in
    let q = String(readLine()!)

    if let number = Int(q) {
        print(dogamNumber[number]!)
    } else {
        print(dogamString[q]!)
    }
}
