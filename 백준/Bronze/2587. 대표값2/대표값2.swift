
var list: [Int] = []
let count = 5

(0..<count).forEach { _ in
    list.append(Int(readLine()!)!)
}

list.sort()

print("\(list.reduce(0, {$0 + $1}) / count)\n\(list[count/2])")
