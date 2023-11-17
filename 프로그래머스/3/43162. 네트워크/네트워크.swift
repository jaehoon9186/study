import Foundation

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    
    var isVisited = Array(repeating: false, count: n)
    var result = 0
    
    func linkNet(_ row: Int) {
        isVisited[row] = true
        
        for j in 0..<n {
            if j == row {
                continue
            }
            
            if computers[row][j] == 1 && isVisited[j] == false {
                linkNet(j)
            }
        }
    }
    
    for i in 0..<n {
        if isVisited[i] == false {
            result += 1
            linkNet(i)
        }
    }
    
    return result
}