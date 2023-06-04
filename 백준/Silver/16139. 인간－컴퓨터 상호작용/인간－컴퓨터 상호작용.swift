let input = Array(readLine()!)
let t = Int(readLine()!)!

var alphaSumList: [[Character: Int]] = []

var tempDict: [Character: Int] = [:]
for i in Int(UnicodeScalar("a").value)...Int(UnicodeScalar("z").value) {
    if let a = UnicodeScalar(i) {
        tempDict[Character(a)] = 0
    }
}

alphaSumList.append(tempDict)
for i in input {
    tempDict[i]! += 1
    alphaSumList.append(tempDict)
}

for _ in 0..<t {
    let question = readLine()!.split(separator: " ")
    let found = Character(String(question[0]))
    let (startIdx, endIdx) = (Int(question[1])!, Int(question[2])!)

    if let end = alphaSumList[endIdx + 1][found], let start = alphaSumList[startIdx][found] {
        print(end - start)
    }
}
