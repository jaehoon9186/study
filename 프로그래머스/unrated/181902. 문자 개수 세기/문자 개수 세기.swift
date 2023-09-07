import Foundation

func solution(_ my_string:String) -> [Int] {
    
    var dict: [String: Int] = [:]
    
    for i in Int(UnicodeScalar("a").value)...Int(UnicodeScalar("z").value) {
        dict[String(UnicodeScalar(i)!)] = 0
    }
    
    for i in Int(UnicodeScalar("A").value)...Int(UnicodeScalar("Z").value) {
        dict[String(UnicodeScalar(i)!)] = 0
    }
    
    for i in my_string {
        dict[String(i), default: 0] += 1
    }
    
    return dict.sorted { $0.key < $1.key }.map { $0.value }
}