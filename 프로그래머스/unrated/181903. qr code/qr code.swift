import Foundation

func solution(_ q:Int, _ r:Int, _ code:String) -> String {
    return code.enumerated().filter { i, _ in i % q == r }.map { String($1) }.joined()
}