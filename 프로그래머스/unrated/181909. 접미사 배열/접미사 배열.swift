import Foundation

func solution(_ my_string:String) -> [String] {
    return (1...my_string.count).map { String(my_string.suffix($0)) }.sorted()
}