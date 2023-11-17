import Foundation

func solution(_ sizes:[[Int]]) -> Int {
    
    var maxW = 0
    var maxH = 0
    
    for i in sizes {
        maxW = max(maxW, max(i[0], i[1]))
        maxH = max(maxH, min(i[0], i[1]))
    }
    
    return maxW * maxH
}