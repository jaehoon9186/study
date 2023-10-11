func solution(_ n:Int, _ arr1:[Int], _ arr2:[Int]) -> [String] {
    var answer: [String] = []
    
    for i in zip(arr1, arr2) {
        var bit = String(i.0 | i.1, radix: 2)
        bit = String(repeating: "0", count: n - bit.count) + bit
        answer.append(bit.map { $0 == "0" ? " " : "#" }.joined())
    }
    
    return answer
}