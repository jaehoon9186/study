import Foundation

let t = Int(readLine()!)!
var numberList: [Int] = []

for _ in 0..<t {
    let input = Int(readLine()!)!
    numberList.append(input)
}

numberList.sort()

let resultA = Double(numberList.reduce(0, +)) / Double(t)
print(Int(resultA.rounded()))

print(numberList[t/2])

let resultC = Dictionary(grouping: numberList, by: { $0 })
let maxCount = resultC.max { a, b in a.value.count < b.value.count }!.value.count
let sortedListResultC = resultC.filter { $0.value.count == maxCount }.sorted { $0.key < $1.key }
print(sortedListResultC.count >= 2 ? sortedListResultC[1].key : sortedListResultC[0].key)

print(abs(numberList.last! - numberList.first!))

