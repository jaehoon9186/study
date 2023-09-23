import Foundation

func solution(_ numbers:[Int]) -> Int {
    
    let sortedNums = numbers.sorted()
    let sortedNumsRev = numbers.sorted(by: >)
    
    return max(sortedNums[0] * sortedNums[1], sortedNumsRev[0] * sortedNumsRev[1])
}