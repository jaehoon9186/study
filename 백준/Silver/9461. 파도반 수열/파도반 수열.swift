let input = Int(readLine()!)!
var list: [Int] = Array(repeating: 0, count: 100 + 1)

list[0] = 0
list[1] = 1
list[2] = 1

for i in 3...100 {
    list[i] = list[i-2] + list[i-3]
}

for _ in 0..<input {
    print(list[Int(readLine()!)!])
}
