let t = Int(readLine()!)!
var chongDict: [String: Bool] = ["ChongChong": true]


for _ in 0..<t {
    let input = readLine()!.split(separator: " ").map { String($0) }
    let (a, b) = (input[0], input[1])

    for i in [a, b] {
        if chongDict.keys.contains(i) == false {
            chongDict[i] = false
        }
    }

    if chongDict[a]! || chongDict[b]! {
        chongDict[a] = true
        chongDict[b] = true
    }
}

print(chongDict.filter { $0.value }.count)
