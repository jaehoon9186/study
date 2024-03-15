
func zFunc(n: Int, r: Int, c: Int) -> Int {
    if n == 0 {
        return 0
    }

    let half = 1 << (n - 1)

    if r < half && c < half {
        return zFunc(n: n-1, r: r, c: c)
    } else if r < half && c >= half {
        return half * half + zFunc(n: n-1, r: r, c: c-half)
    } else if r >= half && c < half {
        return 2*half*half + zFunc(n: n-1, r: r-half, c: c)
    } else {
        return 3*half*half + zFunc(n: n-1, r: r-half, c: c-half)
    }

}


let input = readLine()!.split(separator: " ").map { Int($0)! }

let (n, r, c) = (input[0], input[1], input[2])

print(zFunc(n: n, r: r, c: c))
