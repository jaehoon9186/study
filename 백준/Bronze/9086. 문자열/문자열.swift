let t = Int(readLine()!)!

(1...t).forEach { _ in
    let str = readLine()!
    print("\(str[str.startIndex])\( str[str.index(before: str.endIndex)])")
}
