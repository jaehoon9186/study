import Foundation

func solution(_ str_list:[String]) -> [String] {
    
    for (i, v) in str_list.enumerated() {
        if v == "l" {
            return Array(str_list[0..<i])
        } else if v == "r" {
            return Array(str_list[(i+1)...])
        }
    }
    
    return []
}