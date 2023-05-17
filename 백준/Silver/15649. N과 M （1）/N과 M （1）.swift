func permutation(_ numbers: [Int], _ n: Int, _ r: Int, _ visit: inout [Bool], _ output: [Int] = []) {
    if output.count >= r {
        print(output.map { String($0) }.joined(separator: " "))
        return
    }

    var temp = output

    for i in 0..<n {
        if visit[i] == false {
            visit[i] = true
            temp.append(numbers[i])
            permutation(numbers, n, r, &visit, temp)
            temp.removeLast()
            visit[i] = false
        }
    }

}


let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, r) = (input[0], input[1])
let arr = Array<Int>(1...n)
var checklist: [Bool] = Array(repeating: false, count: n)

permutation(arr, n, r, &checklist)


