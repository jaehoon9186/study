func solution(_ m:String, _ musicinfos:[String]) -> String {
    
    var result = "(None)"
    var maxTime = 0
    
    var input: [String] = []
    for i in m {
        if i == "#" {
            input[input.endIndex - 1].removeLast()
            input[input.endIndex - 1] += String(i)
            continue
        } 
        input.append(String(i) + "0")
    }
    let updatedInput = input.joined()
    
    for i in musicinfos {
        let temp = i.split(separator: ",")
        let (startTemp, endTemp) = (temp[0].split(separator: ":").map { Int($0)! }, temp[1].split(separator: ":").map { Int($0)! })
        let start = zip(startTemp, [60, 1]).map { $0 * $1 }.reduce(0, +)
        let end = zip(endTemp, [60, 1]).map { $0 * $1 }.reduce(0, +)
        let (music, codeTemp) = (String(temp[2]), temp[3])
        
        let time = end - start
        var code: [String] = []
        
        for i in codeTemp {
            if i == "#" {
                code[code.endIndex - 1].removeLast()
                code[code.endIndex - 1] += String(i)
                continue
            } 
            code.append(String(i) + "0")
        }
        
        let fullCode = Array(repeating: code, count: (time / code.endIndex) + 1).flatMap { $0 }[0..<time].joined()

        
        if fullCode.contains(updatedInput) && time > maxTime {
            result = music
            maxTime = time
        }
        
        
    }
    
    
    return result 
}