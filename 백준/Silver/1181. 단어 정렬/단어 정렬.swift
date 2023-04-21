let input = Int(readLine()!)!
var words: [String] = []

(0..<input).forEach { _ in
    words.append(readLine()!)
}

words = Set(words).sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0.count < $1.count
})


words.forEach {
    print($0)
}
