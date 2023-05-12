let input = readLine()!.split(separator: " ").map { Int($0)! }
let (totalCount, minLength) = (input[0], input[1])
var wordDict: [String: Int] = [:]

for _ in 0..<totalCount {
    let word = readLine()!
    if word.count < minLength {
        continue
    }
    wordDict[word, default: 0] += 1
}

let result = wordDict.sorted(by: {
    if $0.value == $1.value {
        if $0.key.count == $1.key.count {
            return $0.key < $1.key
        }
        return $0.key.count > $1.key.count
    }
    return $0.value > $1.value
} ).map { $0.key }

result.forEach {
    print($0)
}
