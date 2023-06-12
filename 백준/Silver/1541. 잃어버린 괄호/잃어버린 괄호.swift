import Foundation

let input = "0" + String(readLine()!)
var str = input.split(separator: "-", maxSplits: 1)
if str.count == 1 {
    str.append("0")
}
let plus = str[0].components(separatedBy: ["+"]).map { Int($0)! }.reduce(0, +)
let minus = str[1].components(separatedBy: ["+", "-"]).map { Int($0)! }.reduce(0, +)

print(plus - minus)

