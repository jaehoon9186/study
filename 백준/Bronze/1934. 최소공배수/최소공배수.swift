let t = Int(readLine()!)!

for _ in (0..<t) {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    var (a, b) = (input[0], input[1])
    if b > a {
        swap(&a, &b)
    }

    print(lcm(a, b))

}


func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }

    return gcd(b, a%b)
}

func lcm(_ a: Int, _ b: Int) -> Int {
    return a * b / gcd(a, b)
}

