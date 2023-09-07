import Foundation

func solution(_ my_string:String, _ n:Int) -> String {
    return my_string.map { String($0) }[(my_string.count - n)...].joined()
}