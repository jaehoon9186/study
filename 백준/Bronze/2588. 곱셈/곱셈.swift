import Foundation

let input1 = Int(readLine()!)!
let input2 = readLine()!
let input2St = input2.map { Int(String($0))! }

print(input1 * input2St[2])
print(input1 * input2St[1])
print(input1 * input2St[0])
print(input1 * Int(input2)!)
