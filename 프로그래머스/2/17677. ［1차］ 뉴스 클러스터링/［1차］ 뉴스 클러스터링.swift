import Foundation

func solution(_ str1:String, _ str2:String) -> Int {
    
    var a = str1.lowercased().map { String($0) }
    var b = str2.lowercased().map { String($0) }
    
    var aList = (1..<a.count).map { a[($0-1)...$0].joined() }.filter { $0.allSatisfy{ $0.isLetter } }.sorted()
    var bList = (1..<b.count).map { b[($0-1)...$0].joined() }.filter { $0.allSatisfy{ $0.isLetter } }.sorted()
    
    let interCount = inter(aList, bList).count
    let unionCount = union(aList, bList).count
    
    
    if unionCount == 0 {
        return 65536
    } 
    
    return Int(Double(interCount)/Double(unionCount) * 65536)
}


func inter(_ first: [String], _ second: [String]) -> [String] {
    var result: [String] = []
    var a = first
    var b = second
    
    while a.count > 0 && b.count > 0 {
        let (tempA, tempB) = (a.first!, b.first!)
        
        if tempA == tempB {
            result.append(tempA)
            a.removeFirst()
            b.removeFirst()
        } else if tempA > tempB {
            b.removeFirst()
        } else {
            a.removeFirst()
        }
    }
    
    return result
}

func union(_ first: [String], _ second: [String]) -> [String] {
    var result: [String] = []
    var a = first
    var b = second
    
    while a.count > 0 || b.count > 0 {
        
        if a.first == nil {
            result.append(b.removeFirst())
            continue
        } else if b.first == nil {
            result.append(a.removeFirst())
            continue
        }
        
        let (tempA, tempB) = (a.first!, b.first!) 
        
        if tempA == tempB {
            result.append(tempA)
            a.removeFirst()
            b.removeFirst()
        } else if tempA > tempB {
            result.append(tempB)
            b.removeFirst()
        } else {
            result.append(tempA)
            a.removeFirst()
        }
        
        
    }
    
    return result
}