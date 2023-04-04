let input = Int(readLine()!)!

var maxTagetNum = 1
// group 2 = [1/1], 3 = [1/2, 2/1]
var groupNum = 2
var tagetDistance = 1

// find group
while true {
    if input <= maxTagetNum {
        break
    }

    groupNum += 1
    tagetDistance += 1
    maxTagetNum += tagetDistance
}

var groupStart = maxTagetNum - groupNum + 2
var a = 1
var b = groupNum - 1


while true {
    if groupStart == input {
        break
    }

    groupStart += 1
    a += 1
    b -= 1
}

if groupNum % 2 == 0 {
    (a, b) = (b, a)
}

print("\(a)/\(b)")
