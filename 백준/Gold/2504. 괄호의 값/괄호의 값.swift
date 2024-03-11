
let list = Array(readLine()!)
var stack: [Character] = []

var result = 0
var temp = 1

for i in 0..<list.count {
    let s = list[i]

    if s == "(" {
        temp *= 2
        stack.append(s)
        continue
    } else if s == "[" {
        temp *= 3
        stack.append(s)
        continue
    }

    guard let last = stack.last else {
        result = 0
        break
    }

    if last == "(", s == ")" {
        if list[i - 1] == "(" {
            result += temp
        }
        stack.removeLast()
        temp /= 2
    } else if last == "[", s == "]" {
        if list[i - 1] == "[" {
            result += temp
        }
        stack.removeLast()
        temp /= 3
    } else {
        result = 0
        break
    }

}

if stack.isEmpty {
    print(result)
} else {
    print(0)
}