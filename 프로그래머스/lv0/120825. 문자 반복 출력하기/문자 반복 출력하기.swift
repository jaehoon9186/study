import Foundation

func solution(_ my_string:String, _ n:Int) -> String {
    return my_string.flatMap { Array(repeating: String($0), count: n) }.joined()
}