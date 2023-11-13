import Foundation

func solution(_ s:String) -> Int {
    
    var list = s.map { String($0) }
    var result = 0
    
    for i in 0..<list.count {
        if isCorrect(list) {
            result += 1
        }
        
        let temp = [list.removeFirst()]
        list += temp
    }
    
    return result
}

func isCorrect(_ p: [String]) -> Bool {
    let dict: [String: String] = [
        "[": "]",
        "{": "}",
        "(": ")" 
    ]
    var stack: [String] = []
    var sum = 0
    
    for i in p {
        if dict.keys.contains(i) {
            stack.append(i)
            continue
        } 
        
        if let pop = stack.popLast(), let rightSide = dict[pop], i == rightSide {
            continue
        }
        
        return false
    }
    
    return stack.count == 0
}