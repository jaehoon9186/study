import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (a, b, v) = (Double(input[0]), Double(input[1]), Double(input[2]))

var n = ceil((v-a)/(a-b))

print(Int(n + 1))
