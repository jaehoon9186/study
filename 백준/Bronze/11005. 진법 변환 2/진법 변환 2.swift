
let nums = readLine()!.split(separator: " ").map { Int($0)! }

let num = nums[0]
let before = nums[1]

print(String(num, radix: before).uppercased())

