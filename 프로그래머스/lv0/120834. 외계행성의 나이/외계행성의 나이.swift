import Foundation

func solution(_ age:Int) -> String {
    
    var dic: [String: String] = [:]
    
    for (i, v) in "abcdefghijklmnopqrstuvwyxz".map { String($0) }.enumerated() {
        dic[String(i)] = v
    }
    
    return String(age).map { dic[String($0)] ?? "" }.joined()
}