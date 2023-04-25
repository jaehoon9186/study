let input = readLine()!.split(separator: " ").map { Int($0)! }
let (a, b) = (input[0], input[1])
var set1 = Set<String>()
var set2 = Set<String>()

for _ in (0..<a) {
    set1.insert(readLine()!)
}

for _ in (0..<b) {
    set2.insert(readLine()!)
}

var answer = set1.intersection(set2).sorted()

print(answer.count)

for i in answer {
    print(i)
}
