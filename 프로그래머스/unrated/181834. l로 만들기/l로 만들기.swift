import Foundation

func solution(_ myString:String) -> String {
    
    return myString.map { String($0) < "l" ? "l" : String($0) }.joined()
}