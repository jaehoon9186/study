import Foundation

func solution(_ arr:[Int]) -> [Int] {
    
    let twoList = arr.enumerated().filter { $1 == 2 }.map { $0.0 }
    
    return twoList.isEmpty ? [-1] : Array(arr[twoList.first!...twoList.last!])
}