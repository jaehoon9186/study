let t = Int(readLine()!)!
var result = 0
var strSet = Set<String>()

for _ in 0..<t {
    let str = readLine()!

    if str == "ENTER" {
        result += strSet.count
        strSet.removeAll()
        continue
    }
    strSet.insert(str)
}

result += strSet.count

print(result)
