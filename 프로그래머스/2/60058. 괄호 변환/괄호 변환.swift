import Foundation

func solution(_ p:String) -> String {
    return getCorrectBracket(p)
}

func getCorrectBracket(_ w: String) -> String {
    
    if w.isEmpty {
        return ""
    }
    
    let idx = w.index(w.startIndex, offsetBy: getFirstBalancedIndex(w))
    let u = String(w[w.startIndex..<idx])
    let v = String(w[idx...])
    
    if isCorrectBracket(u) {
        return u + getCorrectBracket(v)
    } else {
        var removeAndReversed = u.map { $0 == "(" ? String(")") : String("(") }
        removeAndReversed.removeFirst()
        removeAndReversed.removeLast()
        return "(" + getCorrectBracket(v) + ")" + removeAndReversed.joined()
    }
}


func isCorrectBracket(_ s: String) -> Bool {
    var count = 0
    
    for i in s {
        if i == "(" {
            count += 1
        } else {
            count -= 1
        }
        
        if count < 0 {
            return false
        }
    }
    
    return true
}

func getFirstBalancedIndex(_ s: String) -> Int {
    var index = 0
    var right = 0
    var left = 0
    
    for i in s {
        index += 1
        
        if i == "(" {
            left += 1
        } else {
            right += 1
        }
        
        if right == left {
            break
        }
    }
    
    return index
}