import Foundation

func solution(_ n:Int, _ info:[Int]) -> [Int] {
    
    var diff = 0
    var maxList = Array(repeating: 0, count: 11)
    
    for i in 0..<(1<<11) {
        var aPoint = 0
        var rPoint = 0
        var arrowCount = 0
        var temp = Array(repeating: 0, count: 11)
        
        for j in 0..<11 {
            // 라이언 윈
            if i & (1 << j) != 0 {
                // j index
                rPoint += (10 - j)
                temp[j] = info[j] + 1
                arrowCount += temp[j]            
            } else { // 어피치 윈
                if info[j] != 0 {
                    aPoint += (10 - j)
                }
            }
        }
        
        if arrowCount > n { continue }
        if aPoint > rPoint { continue } 
        
        temp[10] = n - arrowCount
        
        let difftemp = rPoint - aPoint 
        if diff < difftemp {
            diff = difftemp
            maxList = temp
            continue
        }
        
        // 같을때
        if diff == difftemp {
            
            for k in (0..<11).reversed() {
                if temp[k] > maxList[k] {
                    maxList = temp
                    break
                }
            }
            
        }
    }
    
    return diff == 0 ? [-1] : maxList
}