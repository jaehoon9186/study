import Foundation

let input1 = Int(readLine()!)!
let input2 = readLine()!

print(
    input1 * Int(String(input2[input2.index(input2.startIndex, offsetBy: 2)]))!
)
print(
    input1 * Int(String(input2[input2.index(input2.startIndex, offsetBy: 1)]))!
)
print(
    input1 * Int(String(input2[input2.index(input2.startIndex, offsetBy: 0)]))!
)
print(input1 * Int(input2)!)