let input = Int(readLine()!)!
var gigle: [String: String] = [:]

(0..<input).forEach { _ in
    let temp = readLine()!.split(separator: " ").map { String($0) }
    let (name, state) = (temp[0], temp[1])
    gigle[name] = state
}

let enterList = gigle.filter { $0.value == "enter" }.keys.sorted(by: { $0 > $1 })

for i in enterList {
    print(i)
}
