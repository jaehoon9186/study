func solution(_ files:[String]) -> [String] {
    
    var splitedList: [(String, Int, Int)] = []
    
    for (i, v) in files.enumerated() {
        let head = v.prefix { $0.isNumber == false }.lowercased()
        let temp = v.drop { $0.isNumber == false }
        let number = Int(temp.prefix { $0.isNumber == true })!
        
        splitedList.append((head, number, i))
    }
    
    let sorted = splitedList.sorted { first, second in 
                                     if first.0 == second.0 {
                                         if first.1 == second.1 {
                                             return first.2 < second.2
                                         }
                                         return first.1 < second.1
                                     }
                                     return first.0 < second.0
                                    }
    
    return sorted.map { files[$0.2] }
}