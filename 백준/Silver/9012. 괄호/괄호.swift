let t = Int(readLine()!)!
let parenthesisDict: [String: String] = [")": "("]

for _ in 0..<t {
    let input = Array(readLine()!).map { String($0) }

    print(isParenthesisString(input) ? "YES" : "NO")
}

func isParenthesisString(_ psList: [String]) -> Bool {
    var stack = Array<String>()

    for i in psList {
        if i == "(" {
            stack.append(i)
            continue
        }

        if stack.isEmpty == false && stack.last == parenthesisDict[i] {
            stack.removeLast()
        } else {
            return false
        }
    }

    return stack.isEmpty ? true : false
}
