import Foundation

func solution(_ common:[Int]) -> Int {
    return common[2] + common[0] == common[1] * 2 ? 
    common[common.count - 1] + common[1] - common[0] : 
    common[common.count - 1] * (common[1] / common[0])
}