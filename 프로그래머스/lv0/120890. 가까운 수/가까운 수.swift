import Foundation

func solution(_ array:[Int], _ n:Int) -> Int {
    
    let sortedArray = array.sorted()
    let resultIdx = sortedArray.enumerated().map { ($0.offset, abs($0.element - n)) }.min { $0.1 < $1.1 }!.0
    
    return sortedArray[resultIdx]
}