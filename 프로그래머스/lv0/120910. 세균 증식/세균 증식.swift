import Foundation

func solution(_ n:Int, _ t:Int) -> Int {
    return n * (pow(2, t) as NSDecimalNumber).intValue
}