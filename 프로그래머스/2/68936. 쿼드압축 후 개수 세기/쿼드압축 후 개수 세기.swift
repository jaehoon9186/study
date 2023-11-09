import Foundation

func solution(_ arr:[[Int]]) -> [Int] {
    
    var arr = arr
    let len = arr.count
    
    zipQuadtree(&arr, 0, len, 0, len)
    
    var numberCount = Array(repeating: 0, count: 3)
    arr.flatMap { $0 }.map { numberCount[$0] += 1 }
    
    return Array(numberCount[0...1])
}

func isAllSame(_ list: inout [[Int]], _ startY: Int, _ endY: Int, _ startX: Int, _ endX: Int) -> Bool {
    let firstNum = list[startY][startX]
    
    for i in startY..<endY {
        for j in startX..<endX {
            if firstNum != list[i][j] {
               return false
            }
        }
    }
    
    return true
}

func setOneNum(_ list: inout [[Int]], _ startY: Int, _ endY: Int, _ startX: Int, _ endX: Int) {
    let firstNum = list[startY][startX]
    
    for i in startY..<endY {
        for j in startX..<endX {
            list[i][j] = 2
        }
    }
    
    list[startY][startX] = firstNum
}

func zipQuadtree(_ list: inout [[Int]], _ startY: Int, _ endY: Int, _ startX: Int, _ endX: Int) {
    
    if isAllSame(&list, startY, endY, startX, endX) {
        setOneNum(&list, startY, endY, startX, endX)
        return
    }
    
    let half = (endY - startY) / 2
    
    zipQuadtree(&list, startY, endY-half, startX, endX-half)
    zipQuadtree(&list, startY, endY-half, startX+half, endX)
    zipQuadtree(&list, startY+half, endY, startX, endX-half)
    zipQuadtree(&list, startY+half, endY, startX+half, endX)
}