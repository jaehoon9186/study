import Foundation

func solution(_ myString:String, _ pat:String) -> Int {
    let dict: [Character: String] = ["A": "B", "B": "A"]
    return myString.map { dict[$0]! }.joined().contains(pat) ? 1 : 0
}