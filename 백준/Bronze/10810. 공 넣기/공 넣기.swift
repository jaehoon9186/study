let input = readLine()!.split(separator: " ").map { Int($0)! }
let count = input[0], t = input[1]
var arr = Array(repeating: 0, count: count)

for _ in 0..<t {
    let input2 = readLine()!.split(separator: " ").map { Int($0)! }
    let i = input2[0] - 1, j = input2[1], k = input2[2]
    let tagetIdx = Array<Int>(i..<j)

    arr.indices.forEach {
        if tagetIdx.contains($0) {
            arr[$0] = k
        }
    }
}

print(arr.map { String($0) }.joined(separator: " ") )
