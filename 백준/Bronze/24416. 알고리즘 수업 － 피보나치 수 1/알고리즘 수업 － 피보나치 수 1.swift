
func fib(_ n: Int) -> Int {
    if n == 1 || n == 2 {
        return 1
    } else {
        return fib(n - 1) + fib(n - 2)
    }
}

let input = Int(readLine()!)!

print(fib(input), input - 2)
