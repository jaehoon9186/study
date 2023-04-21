let input = Int(readLine()!)!
var users: [(Int, String)] = []

(0..<input).forEach { _ in
    let temp = readLine()!.split(separator: " ")
    let user = (Int(temp[0])!, String(temp[1]))
    users.append(user)
}

users.sort(by: {
    return $0.0 < $1.0
})

users.forEach {
    print($0.0, $0.1)
}
