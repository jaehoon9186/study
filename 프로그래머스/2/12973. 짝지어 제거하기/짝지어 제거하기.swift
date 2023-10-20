import Foundation

func solution(_ s:String) -> Int {
    
    var list = s.map { String($0) }
    var checkStack: [String] = []
    
    for i in list {
        checkStack.append(i)
        
        if checkStack.count < 2 {
            continue
        }
        
        if checkStack[checkStack.count - 1] == checkStack[checkStack.count - 2] {
            checkStack.popLast()
            checkStack.popLast()
        }
    }
    
    
    return checkStack.isEmpty ? 1 : 0
}