import Foundation

func solution(_ num_list:[Int]) -> [Int] {
    let lastIdx = num_list.count - 1
    let temp = num_list[lastIdx] > num_list[lastIdx - 1] ? num_list[lastIdx] - num_list[lastIdx - 1] : num_list[lastIdx] * 2
    
    return num_list + [temp]
}