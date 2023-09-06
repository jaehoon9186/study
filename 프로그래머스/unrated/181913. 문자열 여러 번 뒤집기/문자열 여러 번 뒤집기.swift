import Foundation

func solution(_ my_string:String, _ queries:[[Int]]) -> String {
    
    var list = my_string.map { String($0) }
    
    for i in queries {
        var (s, e) = (i[0], i[1])
        list = Array(list[0..<s]) + Array(list[s...e]).reversed() + Array(list[(e + 1)...])
    }
    
    return list.joined()
}