import Foundation

let nums = readLine()!.split(separator: " ").map { String($0)}

let num = nums[0]
let beforeDecimal = Int(nums[1])!

print(Int(num,radix: beforeDecimal)!)