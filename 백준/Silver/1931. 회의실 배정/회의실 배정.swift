let input = Int(readLine()!)!
var timeTable: [[Int]] = []
var result = 0

for _ in 0..<input {
    timeTable.append(readLine()!.split(separator: " ").map { Int($0)! })
}

timeTable.sort {
    if $0[1] == $1[1] {
        return $0[0] < $1[0]
    }
    return $0[1] < $1[1]
}


var endTime = timeTable[0][1]
result += 1

for i in 1..<timeTable.count {
    if endTime <= timeTable[i][0] {
        result += 1
        endTime = timeTable[i][1]
    }
}

print(result)
