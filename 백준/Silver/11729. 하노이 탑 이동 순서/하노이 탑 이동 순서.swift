let n = Int(readLine()!)!
var result = 1

func hanoi(_ n: Int, _ from: Int, _ by: Int, _ to: Int ) {
    if n == 1{
        move(from, to)
    } else {
        hanoi(n - 1, from, to, by)
        move(from, to)
        hanoi(n - 1, by, from, to)
    }
}

func move(_ from: Int, _ to: Int) {
    print("\(from) \(to)")
}

for _ in 0..<n {
    result *= 2
}
print(result - 1)
hanoi(n, 1, 2, 3)
