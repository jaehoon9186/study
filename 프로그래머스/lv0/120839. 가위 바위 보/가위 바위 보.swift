import Foundation

func solution(_ rsp:String) -> String {
    let dict: [Character: String] = ["2":"0", "0":"5", "5":"2"]
    return rsp.map { dict[$0]! }.joined()
}