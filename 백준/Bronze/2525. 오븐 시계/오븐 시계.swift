var input = readLine()!.split(separator: " ").map { Int($0)! }
let input2 = Int(readLine()!)!

input[1] += input2

if input[1] >= 60 {
    input[0] += input[1] / 60
    input[1] %= 60
}

while input[0] >= 24 {
    input[0] -= 24
}

print(input[0], input[1])
