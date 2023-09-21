import Foundation

func solution(_ A:String, _ B:String) -> Int {
    
    var count = 0
    var aList = Array(A)
    var bList = Array(B)
    
    for _ in 0..<aList.count {
        if aList == bList {
            return count 
        }
        aList = [aList[aList.count - 1]] + Array(aList[0..<aList.count - 1])
        count += 1
    }
    
    
    
    return -1
}