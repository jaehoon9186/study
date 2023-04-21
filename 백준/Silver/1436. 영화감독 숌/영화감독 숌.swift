let n = Int(readLine()!)!

var count = 0
var num = 0

while count < n {
    num += 1

    var temp = num

    while temp >= 666 {
        if temp % 1000 == 666 {
            count += 1
            break
        }
        temp /= 10
    }
}

print(num)
