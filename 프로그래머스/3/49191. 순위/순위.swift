import Foundation

func solution(_ n:Int, _ results:[[Int]]) -> Int {
    
    var box = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)
    
    for i in results {
        let (win, lose) = (i[0], i[1])
        
        box[win][lose] = 1
        box[lose][win] = -1
    }
    
    for i in 1...n {
        box[i][i] = 9
    }
    
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                if box[i][k] == 1 && box[k][j] == 1 {
                    box[i][j] = 1
                    box[j][i] = -1
                }
            }
        }
    }
    
    return box[1...].filter { $0[1...].contains(0) == false }.count
}