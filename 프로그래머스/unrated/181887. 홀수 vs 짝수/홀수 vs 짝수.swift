import Foundation

func solution(_ num_list:[Int]) -> Int {
    
    let odd = stride(from: 0, to: num_list.count, by: 2).map { num_list[$0] }.reduce(0) { $0 + $1 }
    let even = stride(from: 1, to: num_list.count, by: 2).map { num_list[$0] }.reduce(0) { $0 + $1 }
    
    if odd > even {
        return odd
    } else {
        return even
    }
}