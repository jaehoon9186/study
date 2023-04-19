while let input = readLine() {
    let sides = input.split(separator: " ").map { Int($0)! }.sorted()

    if sides.reduce(0, { $0 + $1 }) == 0 {
        break
    }

    if sides[2] >= sides[0] + sides[1] {
        print("Invalid")
        continue
    }

    let count = Set(sides).count

    if count == 1 {
        print("Equilateral")
    } else if count == 2 {
        print("Isosceles")
    } else {
        print("Scalene")
    }
}
