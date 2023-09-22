import Foundation

func solution(_ cipher:String, _ code:Int) -> String {
    return cipher.enumerated().map { ($0.offset + 1) % code == 0 ? String($0.element) : "" }.joined()
}