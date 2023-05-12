let t = Int(readLine()!)!
var stack = Array<Int>()

for _ in 0..<t {
    let input = Int(readLine()!)!

    if input == 0 {
        stack.removeLast()
        continue
    }

    stack.append(input)
}

print(stack.reduce(0, +))

