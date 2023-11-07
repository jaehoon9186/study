import Foundation

func solution(_ expression:String) -> Int64 {

    var result: Int = 0
    var gihos: [String] = []
    var express: [String] = []
    
    var temp = ""
    for i in expression {
        if i.isNumber {
            temp += String(i)
        } else {
            gihos.append(String(i))
            express.append(temp)
            express.append(String(i))
            temp = ""
        }
    }
    express.append(temp)
    
    let allSequence = getGiho(Set(gihos).map { String($0) })
    
    for i in allSequence {
        var tempExpress = express
        for j in i {
            while tempExpress.contains(j) {
                let index = tempExpress.firstIndex(of: j)!
                var result = 0
                switch j {
                    case "+":
                        result = Int(tempExpress[index - 1])! + Int(tempExpress[index + 1])!
                    case "-":
                        result = Int(tempExpress[index - 1])! - Int(tempExpress[index + 1])!
                    default :
                        result = Int(tempExpress[index - 1])! * Int(tempExpress[index + 1])!
                }
                
                tempExpress.replaceSubrange((index-1)...(index+1), with: [String(result)])
            }
        }
        
        result = max(result, abs(Int(tempExpress.removeFirst())!))
        
    }
    
    return Int64(result)
}

func getGiho(_ list: [String]) -> [[String]] {
    var result: [[String]] = []
    var checkList: [Bool] = Array(repeating: false, count: list.count)
    
    func perm(_ check: inout [Bool], _ r: Int, _ output: [String] = []) {
        var output = output
        
        if output.count == r {
            result.append(output)
            return
        }
        
        for i in 0..<list.count {
            if check[i] == false {
                check[i] = true
                output.append(list[i])
                perm(&check, r, output)
                output.removeLast()
                check[i] = false
            }
        }
    }
    
    perm(&checkList, list.count)
    
    return result
}