import Foundation

func solution(_ my_string:String, _ index_list:[Int]) -> String {
    
    let list = my_string.map { String($0) }

    var result: [String] = []
    
    for i in index_list {
        result.append(list[i])
    }
    
    return result.joined()
}