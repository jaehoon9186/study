let input = readLine()!.split(separator: " ").map { Int($0)! }
let (start, end) = (input[0], input[1])
var list = Array(repeating: true, count: end + 1)

list[0] = false
list[1] = false

for i in 2...end {
    if list[i] == false {
        continue
    }

    for j in stride(from: i * 2, to: end + 1, by: i) {
        list[j] = false
    }
}

for i in start...end {
    if list[i] == true {
        print(i)
    }
}
