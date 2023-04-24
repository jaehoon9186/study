let input1 = Int(readLine()!)!
let cards = readLine()!.split(separator: " ").map{ Int($0)! }
let input2 = Int(readLine()!)!
let cardNumbers = readLine()!.split(separator: " ").map { Int($0)! }

var myCard: [Int: Int] = [:]

for i in cards {
    myCard[i, default: 0] += 1
}

for i in cardNumbers {
    print(myCard[i, default: 0], terminator: " ")
}
