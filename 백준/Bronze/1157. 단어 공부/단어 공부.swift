let input = readLine()!
var alphabetCount: [String:Int] = [:]
var revAlpha: [Int:[String]] = [:]

input.forEach {
    alphabetCount[$0.uppercased(), default: 0] += 1
}

alphabetCount.forEach {
    revAlpha[$1, default: []].append($0)
}

var a = revAlpha.sorted { $0.key > $1.0 }[0].value
print(a.count < 2 ? a[0] : "?")
