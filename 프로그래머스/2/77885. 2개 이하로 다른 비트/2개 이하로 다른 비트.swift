import Foundation

func solution(_ numbers:[Int64]) -> [Int64] {
    var result: [Int64] = []
    
    for i in numbers {
        if i % 2 == 0 {
            result.append(i + 1)
            continue
        }
        
        var s = Array("0" + String(i, radix: 2))
        var replaceIndex = 0
        for index in 0..<s.count - 1 {
            if s[index] == "0" && s[index + 1] == "1" {
                replaceIndex = index
            }
        }
        s.replaceSubrange(replaceIndex...replaceIndex+1, with: ["1", "0"])
        
        result.append(Int64(s.map { String($0) }.joined(), radix: 2)!)
    }
    
    return result
}