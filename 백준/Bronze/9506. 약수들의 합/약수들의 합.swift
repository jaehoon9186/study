
while let input = readLine() {
    let n = Int(input)!
    var temp: [Int] = []

    if n == -1 {
        break
    }

    (1...n/2).forEach { i in
        if n % i == 0 {
            temp.append(i)
        }
    }

    let sum = temp.reduce(0) { $0 + $1 }

    if sum == n {
        // 6 = 1 + 2 + 3
        print("\(n) = \(temp.map { String($0) }.joined(separator: " + ") )")
    } else {
        print("\(n) is NOT perfect.")
    }


}
