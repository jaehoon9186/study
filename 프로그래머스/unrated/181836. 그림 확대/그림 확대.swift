import Foundation

func solution(_ picture:[String], _ k:Int) -> [String] {
    var result: [String] = []
    
    for i in picture {
        var temp = ""
        for j in i {
            (0..<k).forEach { _ in
                temp += String(j)
            }
        }
        
        (0..<k).forEach { _ in
            result.append(temp)
        }
    }
    
    return result
}