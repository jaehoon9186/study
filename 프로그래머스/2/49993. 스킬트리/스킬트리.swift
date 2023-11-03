import Foundation

func solution(_ skill:String, _ skill_trees:[String]) -> Int {
    var result = 0
    var skillQueue = skill.map { $0 }
    
    for i in skill_trees {
        var tempSQSlice = skillQueue[skillQueue.indices]
        var flag = true
        for s in i {
            if tempSQSlice.contains(s) == false {
                continue
            }
            if let first = tempSQSlice.popFirst(), first != s {
                flag = false
                break
            }
        }
        
        result += flag ? 1 : 0
    }
    
    return result
}