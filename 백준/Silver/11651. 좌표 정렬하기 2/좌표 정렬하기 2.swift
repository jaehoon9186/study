let input = Int(readLine()!)!
var dotList: [(Int, Int)] = []

(0..<input).forEach { _ in
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let xy = (temp[0], temp[1])
    dotList.append(xy)
}

dotList = dotList.sorted(by: { (first, second) -> Bool in
    if first.1 == second.1 {
        return first.0 < second.0
    }
    return first.1 < second.1
})

for i in dotList {
    print(i.0, i.1)
}
