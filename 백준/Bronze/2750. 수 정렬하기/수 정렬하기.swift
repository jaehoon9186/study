var n = Int(readLine()!)!
var list: [Int] = []

for _ in (0..<n) {
    let input = Int(readLine()!)!

    if list.isEmpty {
        list.append(input)
        continue
    }

    for i in list.indices {
        if input < list[i] {
            list.insert(input, at: i)
            break
        }

        if i == list.count - 1 {
            list.append(input)
        }
    }

}


for i in list {
    print(i)
}
