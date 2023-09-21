import Foundation

func solution(_ my_str:String, _ n:Int) -> [String] {
    
    
    var str = my_str
    var result: [String] = []
    
    while str.isEmpty == false {
        result.append(String(str.prefix(n)))

        var count = str.count >= n ? n : str.count
        str.removeFirst(count)
    }
    
    return result
}