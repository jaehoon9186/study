let input = readLine()!.split(separator: " ").map { Int($0)! }
var numbers = Array(1...input[0])

(1...input[1]).forEach { _ in
    let range = readLine()!.split(separator: " ").map { Int($0)! }

    var (lHand, rHand) = (range[0] - 1, range[1] - 1)

    while lHand < rHand {
        (numbers[lHand], numbers[rHand]) = (numbers[rHand], numbers[lHand])

        lHand += 1
        rHand -= 1
    }
}

print(numbers.map { String($0) }.joined(separator: " "))
