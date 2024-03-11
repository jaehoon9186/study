let list = Array(readLine()!)
var stickCount = 0
var result = 0

for i in 0..<list.count {
    if list[i] == "(" {
        stickCount += 1
        continue
    }
    if i < 1 {
        break
    }

    stickCount -= 1
    if list[i - 1] == "(" {
        result += stickCount
    } else {
        result += 1
    }
}

print(result)
