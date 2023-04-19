
var angle: [Int] = []
var sum = 0

(0..<3).forEach { _ in
    let input = Int(readLine()!)!
    sum += input
    angle.append(input)
}

if sum == 180 {
    let count = Set(angle).count

    if count == 1 {
        print("Equilateral")
    } else if count == 2 {
        print("Isosceles")
    } else {
        print("Scalene")
    }
} else {
    print("Error")
}
