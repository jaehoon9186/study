var input = readLine()!.split(separator: " ").map { Int($0)! }.sorted()

if input[2] >= input[0] + input[1] {
    input[2] = input[0] + input[1] - 1
}

print(input.reduce(0, { $0 + $1 }))
