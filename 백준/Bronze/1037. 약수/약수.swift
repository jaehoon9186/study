let t = Int(readLine()!)!
let numberList = readLine()!.split(separator: " ").map { Int($0)! }.sorted(by: <)
print(numberList[0] * numberList[numberList.count - 1])
