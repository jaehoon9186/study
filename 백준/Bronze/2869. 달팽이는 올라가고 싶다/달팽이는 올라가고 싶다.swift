import Foundation

let input = readLine()!.split(separator: " ").map { Double($0)! }
let (a, b, v) = (input[0], input[1], input[2])

var n = ceil((v-a)/(a-b))

print(Int(n + 1))
