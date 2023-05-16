func factorial(_ number: Int) -> Int {
    if number <= 1 {
        return 1
    }

    return factorial(number - 1) * number
}

print(factorial(Int(readLine()!)!))
