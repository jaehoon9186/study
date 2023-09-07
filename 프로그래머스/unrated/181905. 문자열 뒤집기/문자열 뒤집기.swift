import Foundation

func solution(_ my_string:String, _ s:Int, _ e:Int) -> String {
    
    var list = my_string.map { String($0) }
    var result = list[0..<s] + list[s...e].reversed() + list[(e+1)...]
    
    return result.joined()
}