let input = readLine()!.split(separator: " ").map { Int($0)! }
var count = Dictionary<Int,Int>()
var answer: Int = 0

for i in input {
    count[i, default: 0] += 1
}

let temp = count.sorted(by: {
    if $0.1 == $1.1 {
        return $0.0 > $1.0
    }
    return $0.1 > $1.1
})

if temp[0].value == 3 {
    answer = 10000 + temp[0].key * 1000
} else if temp[0].value == 2 {
    answer = 1000 + temp[0].key * 100
} else {
    answer = temp[0].key * 100
}

print(answer)
