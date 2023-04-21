let input = Int(readLine()!)!
var list = readLine()!.split(separator: " ").map { Int($0)! }
var dict: [Int: Int] = [:]
let tempList = Set(list).sorted()

for i in tempList.indices {
    dict[tempList[i]] = i
}

for i in list.indices {
    list[i] = dict[list[i]] ?? 0
}

print(list.map { String($0) }.joined(separator: " "))
