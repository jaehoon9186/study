let t = Int(readLine()!)!
var count = 0


func checkGroupWord(_ arr: [String]) -> Bool {
    var before = ""
    var checkList = Array<String>()

    for i in arr {
        if i == before {
            continue
        }
        if checkList.contains(i) {
            return false
        }
        checkList.append(i)

        before = i
    }

    return true
}

(0..<t).forEach { _ in
    let input = Array(readLine()!).map { String($0) }

    if checkGroupWord(input) {
        count += 1
    }

}

print(count)
