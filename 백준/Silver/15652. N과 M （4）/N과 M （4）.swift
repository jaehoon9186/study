func combWithRepitition(_ numbers: [Int], _ n: Int, _ r: Int, _ depth: Int,_ output: inout [Int]) {
    if output.count >= r {
        result += output.map { String($0) }.joined(separator: " ")
        result += "\n"
        return
    }

    for i in depth..<n {
        output.append(numbers[i])
        combWithRepitition(numbers, n, r, i, &output)
        output.removeLast()
    }
}


let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, r) = (input[0], input[1])
let arr = Array<Int>(1...n)
var output: [Int] = []
var result = ""

combWithRepitition(arr, n, r, 0, &output)
print(result)
