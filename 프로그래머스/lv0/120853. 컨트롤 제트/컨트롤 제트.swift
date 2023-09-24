import Foundation

func solution(_ s:String) -> Int {
    
    let newS = s.replacingOccurrences(of: " Z", with: "Z")
    
    return newS.split(separator: " ").map { Int($0) ?? 0 }.reduce(0, +)
}