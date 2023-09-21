import Foundation

func solution(_ arr:[[Int]]) -> [[Int]] {
    
    let colCount = arr[0].count
    let rowCount = arr.count
    
    if colCount == rowCount {
        return arr
    } else if colCount > rowCount {
        return arr + Array(repeating: Array(repeating: 0, count: colCount), count: colCount - rowCount)
    } else {
        return arr.map { $0 + Array(repeating: 0, count: rowCount - colCount) }
    }
}