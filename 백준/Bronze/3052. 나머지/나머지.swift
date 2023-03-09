var remainders = Set<Int>()

(1...10).forEach { _ in
    let number = Int(readLine()!)! % 42
    remainders.insert(number)
}

print(remainders.count)
