import Foundation

func solution(_ dots:[[Int]]) -> Int {
    
    var maxHeight = Int.min
    var minHeight = Int.max
    
    var maxWidth = Int.min
    var minWidth = Int.max
    
    for i in dots {
        maxHeight = max(maxHeight, i[0])
        minHeight = min(minHeight, i[0])
        
        maxWidth = max(maxWidth, i[1])
        minWidth = min(minWidth, i[1])
    }
    
    return (maxHeight - minHeight) * (maxWidth - minWidth)
}