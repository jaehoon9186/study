
let input = Int(readLine()!)!

func factorial(_ num: Int) -> Int {
    if num == 0 {
        return 1
    }
    if num < 2 {
        return num
    }

    return factorial(num - 1) * num
}


print(factorial(input))
