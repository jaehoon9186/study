var n = Int(readLine()!)!
var list: [Int] = []

(0..<n).forEach { _ in
    list.append(Int(readLine()!)!)
}

list.sort()

for i in list {
    print(i)
}
