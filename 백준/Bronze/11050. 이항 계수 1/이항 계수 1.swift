
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, r) = (input[0], input[1])

func factorial(_ num: Int) -> Int {
    if num == 0 {
        return 1
    }

    if num < 2 {
        return num
    }

    return factorial(num - 1) * num
}

print(factorial(n) / (factorial(n - r) * factorial(r)))

