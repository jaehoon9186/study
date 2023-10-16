func solution(_ dartResult:String) -> Int {
    
    let updatedDart = [" "] + dartResult.map { $0 }
    var result: [Int] = []
    
    var tempNum = ""
    var tempEtc = ""
    
    var numbers: [Int] = []
    var etc: [String] = []
    
    for i in 1..<updatedDart.count {
        if updatedDart[i].isNumber {
            tempNum += String(updatedDart[i])
            if updatedDart[i-1].isNumber == false {
                etc.append(tempEtc)
                tempEtc = ""
            }
        } else {
            tempEtc += String(updatedDart[i])
            if updatedDart[i-1].isNumber {
                numbers.append(Int(tempNum)!)
                tempNum = ""
            }
        }
    }
    etc.removeFirst()
    etc.append(tempEtc)
    
    for i in zip(numbers, etc) {
        var temp = i.0
        let list = i.1.map { $0 }
        
        if list[0] == "T" {
            temp = temp * temp * temp
        } else if list[0] == "D" {
            temp = temp * temp
        } 
        
        result.append(temp)
        
        if list.count < 2 {
            continue
        }
        
        if list[1] == "*" {
            result[result.count - 1] *= 2
            if result.count > 1 {
                result[result.count - 2] *= 2
            }
        } else {
            result[result.count - 1] *= -1
        }
        
    }
    
    return result.reduce(0, +)
}