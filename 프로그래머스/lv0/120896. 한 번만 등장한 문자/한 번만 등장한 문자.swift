import Foundation

func solution(_ s:String) -> String {
    
    let list: [String] = s.map { String($0) }
    var dict: [String: Int] = [:]
    
    for i in list {
        dict[i, default: 0] += 1
    }
    
    return dict.filter { $1 == 1 }.map { $0.key }.sorted().joined()
}