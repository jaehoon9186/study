import Foundation

func solution(_ new_id:String) -> String {
    
    var newId = new_id
    var temp = ""
    
    newId = newId.lowercased()
    
    for i in newId {
        if i.isLowercase || i.isNumber || ["-", "_", "."].contains(i) {
            temp += String(i)
        }
    }
    newId = temp
    
    
    while newId.contains("..") {
        newId = newId.replacingOccurrences(of: "..", with: ".")
    }
    
    
    if let first = newId.first, first == "." {
        newId.removeFirst()
    }
    if let last = newId.last, last == "." {
        newId.removeLast()
    }
    
    
    if newId.isEmpty {
        newId = "a"
    }
    
    if newId.count >= 16 {
        newId = String(newId[newId.startIndex ..< newId.index(newId.startIndex, offsetBy: 15)])
        
        if let last = newId.last, last == "." {
            newId.removeLast()
        }
    }
    
    while newId.count <= 2 {
        newId += String(newId.last!)
    }
    
    return newId
}