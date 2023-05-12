let parenthesisDict: [Character: Character] = [")": "(", "]": "["]
let leftSideP: [Character] = ["(", "["]

func isParenthesisString(_ psList: [Character]) -> Bool {
    var stack = Array<Character>()

    for i in psList {
        if i.isLetter || i.isWhitespace || i == Character("."){
            continue
        }

        if leftSideP.contains(i){
            stack.append(i)
            continue
        }

        if stack.isEmpty == false &&
            stack.last == parenthesisDict[i] {
            stack.removeLast()
        } else {
            return false
        }
    }

    return stack.isEmpty ? true : false
}

while let input = readLine() {
    if input == "." {
        break
    }

    print(isParenthesisString(Array(input)) ? "yes" : "no")


}
