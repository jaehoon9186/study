import Foundation

func solution(_ s:String) -> Int {
    
    var result = s.count
    var list = s.map { String($0) }
    
    for i in 1...(list.count / 2 + 1) {
        var tempCount: [Int] = []
        var tempStr: [String] = []
        for j in stride(from: 0, to: list.count, by: i) {
            if j + i > list.count {
                tempCount.append(1)
                tempStr.append(list[j..<list.count].joined())
                continue
            }
            
            let str = list[j..<(j + i)].joined()
            
            if let last = tempStr.last, last == str {
                tempCount[tempCount.endIndex - 1] += 1
            } else {
                tempCount.append(1)
                tempStr.append(str)
            }
            
        }
        
        result = min(result, tempCount.filter { $0 != 1 }.map { String($0) }.joined().count + tempStr.joined().count)
    }
    
    return result
}