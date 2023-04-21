let input = readLine()!.split(separator: " ").map { Int($0)! }
let (ziphap, taget) = (input[0], input[1])
var ziphapSet = Set<String>()
var answer = 0

(0..<ziphap).forEach { _ in
    ziphapSet.insert(readLine()!)
}

(0..<taget).forEach { _ in
    if ziphapSet.contains(readLine()!) {
        answer += 1
    }
}

print(answer)
