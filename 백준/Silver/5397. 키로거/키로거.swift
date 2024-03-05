
let n = Int(readLine()!)!

for _ in 0..<n {
    var stackL: [Character] = []
    var stackR: [Character] = []
    let input = Array(readLine()!)

    for s in input {
        switch s {
        case "<":
            if stackL.isEmpty == false {
                stackR.append(stackL.removeLast())
            }
        case ">":
            if stackR.isEmpty == false {
                stackL.append(stackR.removeLast())
            }
        case "-":
            if stackL.isEmpty == false {
                stackL.removeLast()
            }
        default:
            stackL.append(s)
        }
    }

    print(String(stackL + stackR.reversed()))
}
