func combination(_ numbers: [Int], _ n: Int, _ r: Int, _ depth: Int,_ output: inout [Int]) {
    if output.count >= r {
        print(output.map { String($0) }.joined(separator: " "))
        return
    }

    for i in depth..<n {
        output.append(numbers[i])
        combination(numbers, n, r, i + 1, &output)
        output.removeLast()
    }
}


let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, r) = (input[0], input[1])
let arr = Array<Int>(1...n)
var output: [Int] = []

combination(arr, n, r, 0, &output)


