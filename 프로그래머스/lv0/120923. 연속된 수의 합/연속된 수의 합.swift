import Foundation

func solution(_ num:Int, _ total:Int) -> [Int] {
    
    let mid = total / num
    
    if num % 2 == 0 {
        return Array((mid - (num / 2) + 1)...(mid + num / 2))
    } else {
        return Array((mid - num / 2)...(mid + num / 2))
    }
}