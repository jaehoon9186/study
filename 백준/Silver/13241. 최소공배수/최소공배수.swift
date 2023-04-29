let input = readLine()!.split(separator: " ").map { Int($0)! }
var (a, b) = (input[1], input[0])
func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }
    return gcd(b, a%b)
}

print(a * b / gcd(a, b))

