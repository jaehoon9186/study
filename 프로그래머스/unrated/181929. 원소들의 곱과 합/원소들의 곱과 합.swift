import Foundation

func solution(_ num_list:[Int]) -> Int {
    let numMul = num_list.reduce(1) { $0 * $1 }
    let numSum = num_list.reduce(0) { $0 + $1 }
    return numMul < numSum * numSum ? 1 : 0
}