var n = Int(readLine()!)!
var count = 0

while n > 0 {
    if n % 5 == 0 {
        count += n / 5
        n %= 5
    } else {
        n -= 3
        count += 1
    }
}

print(n == 0 ? count : -1)
