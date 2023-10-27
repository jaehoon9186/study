func solution(_ msg:String) -> [Int] {
    
    var words: [String] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) } 
    var msg = msg.map { String($0) }
    var temp = ""
    var result: [Int] = []
    
    while msg.isEmpty == false {
        temp += msg.removeFirst()
        
        guard let next = msg.first else {
            result.append(words.firstIndex(of: temp)! + 1)
            break
        }
        
        if let i = words.firstIndex(of: temp), words.contains(temp + next) == false {
            result.append(i + 1)
            words.append(temp + next)
            temp = ""
        } 
        
    }
    
    return result
}