let input = Int(readLine()!)!
var list: [Int] = []
var diff: [Int] = []
var gcdNum: Int = Int.max
var answer = 0

for _ in (0..<input) {
    list.append(Int(readLine()!)!)
}

for i in (1..<list.count) {
    diff.append(list[i] - list[i-1])
}

for i in (1..<diff.count) {
    gcdNum = min(gcdNum, gcd(diff[i],diff[i-1]))
}

for i in diff {
    answer += i / gcdNum - 1
}

print(answer)

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

