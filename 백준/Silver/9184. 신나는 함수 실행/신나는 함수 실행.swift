
var dplist = Array(repeating: Array(repeating: Array(repeating: 1, count: 21), count: 21), count: 21)


for a in 1...20 {
    for b in 1...20 {
        for c in 1...20 {
            if a < b && b < c {
                dplist[a][b][c] = dplist[a][b][c-1] + dplist[a][b-1][c-1] - dplist[a][b-1][c]
            } else {
                dplist[a][b][c] = dplist[a-1][b][c] + dplist[a-1][b-1][c] + dplist[a-1][b][c-1] - dplist[a-1][b-1][c-1]
            }
        }
    }
}



while let input = readLine() {
    let tmp = input.split(separator: " ").map { Int($0)! }
    let (a, b, c) = (tmp[0], tmp[1], tmp[2])

    if a == -1 && b == -1 && c == -1 {
        break
    }

    if a <= 0 || b <= 0 || c <= 0 {
        print("w(\(a), \(b), \(c)) = 1")
        continue
    }

    if a > 20 || b > 20 || c > 20 {
        print("w(\(a), \(b), \(c)) = \(dplist[20][20][20])")
        continue
    }

    print("w(\(a), \(b), \(c)) = \(dplist[a][b][c])")


}

