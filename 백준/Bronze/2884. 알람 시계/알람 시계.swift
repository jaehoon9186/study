let input = readLine()!.split(separator: " ").map { Int($0)! }

var m = input[0] * 60 + input[1]

if m < 45 {
    m += 24 * 60
}

m -= 45

print(m / 60, m % 60)