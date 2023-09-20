import Foundation

func solution(_ a:String, _ b:String) -> String {
    
    var result: [Int] = []
    
    var aList = a.map { Int(String($0))! } 
    var bList = b.map { Int(String($0))! }
    
    var upper = 0
    
    while !aList.isEmpty || !bList.isEmpty {
        
        let aValue = aList.popLast() ?? 0
        let bValue = bList.popLast() ?? 0
        
        let sum = aValue + bValue + upper
        
        result.append(sum % 10)
        upper = sum / 10
    }
    
    if upper > 0 {
        result.append(upper)
    }
    
    return result.reversed().map { String($0) }.joined()
}