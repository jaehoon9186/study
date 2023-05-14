var cards: [Int] = Array(1...Int(readLine()!)!)

var head = 0

while head < cards.count - 1{
    cards.append(cards[head + 1])
    head += 2
}

print(cards[head])
