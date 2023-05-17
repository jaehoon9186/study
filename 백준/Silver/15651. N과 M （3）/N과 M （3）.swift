func permutationWithRepitition(_ numbers: [Int], _ n: Int, _ r: Int, _ output: inout [Int]) {
    if output.count >= r {
        result += output.map { String($0) }.joined(separator: " ")
        result += "\n"
        return
    }

    for i in 0..<n {
        output.append(numbers[i])
        permutationWithRepitition(numbers, n, r, &output)
        output.removeLast()
    }
}


let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, r) = (input[0], input[1])
let arr = Array<Int>(1...n)
var output: [Int] = []
var result = ""

permutationWithRepitition(arr, n, r, &output)

print(result)
