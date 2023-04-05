
let input = readLine()!.split(separator: " ").map { Array($0).map { Int(String($0))! } }
var (arrA, arrB) = (input[0], input[1])
var answer: [Int] = []
var c = 0

while !arrA.isEmpty || !arrB.isEmpty || c != 0 {
    var a = 0
    var b = 0

    if let temp = arrA.popLast() {
        a = temp
    }

    if let temp = arrB.popLast() {
        b = temp
    }

    answer.append((a + b + c) % 10)
    c = (a + b + c) / 10
}

print( answer.reversed().map { String($0) }.joined() )


