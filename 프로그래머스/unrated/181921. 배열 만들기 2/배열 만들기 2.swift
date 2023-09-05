import Foundation

func solution(_ l:Int, _ r:Int) -> [Int] {
    
    let fiveO: Set = ["5", "0"]
    
    let result = (l...r).filter { Set(String($0).map { String($0) }).isSubset(of: fiveO) }
    
    return result.count == 0 ? [-1] : result
}