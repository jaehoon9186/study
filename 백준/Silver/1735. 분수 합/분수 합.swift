let input = readLine()!.split(separator: " ").map { Int($0)! }
let input2 = readLine()!.split(separator: " ").map { Int($0)! }

let (a, b) = (input[0], input[1])
let (c, d) = (input2[0], input2[1])

var bunja = a * d + c * b
var bunmo = b * d


func gcd(_ a: Int, _ b: Int) -> Int {
    var a = a
    var b = b

    if b > a {
        swap(&a, &b)
    }

    if b == 0 {
        return a
    }
    return gcd(b, a%b)
}

let g = gcd(bunmo, bunja)

print(bunja / g, bunmo / g)
