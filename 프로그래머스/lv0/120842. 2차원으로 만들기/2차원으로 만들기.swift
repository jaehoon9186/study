import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [[Int]] {
    
    var result: [[Int]] = []
    
    for i in stride(from: 0, to: num_list.count, by: n) {
        result.append(Array(num_list[i..<(i + n)]))
    }
    
    return result
}