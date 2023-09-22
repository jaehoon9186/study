import Foundation

func solution(_ numlist:[Int], _ n:Int) -> [Int] {
    return numlist.sorted { first, second in 
                           if abs(first - n) == abs(second - n) {
                               return first > second
                           }
                           return abs(first - n) < abs(second - n) }
}