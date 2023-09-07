import Foundation

func solution(_ my_string:String, _ indices:[Int]) -> String {
    var list = my_string.map { String($0) }
    for i in indices.sorted(by: >) {
        list.remove(at: i)
    }
    return list.joined()
}