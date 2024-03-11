
let count = Int(readLine()!)!
var result = 0

for _ in 0..<count {
    let list = Array(readLine()!)
    var stack: [Character] = []

    for s in list {
        if stack.isEmpty {
            stack.append(s)
            continue
        }

        if let last = stack.last, last == s {
            stack.removeLast()
        } else {
            stack.append(s)
        }
    }

    if stack.isEmpty {
        result += 1
    }
}

print(result)
