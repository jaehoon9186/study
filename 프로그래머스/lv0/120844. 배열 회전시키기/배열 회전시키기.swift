import Foundation

func solution(_ numbers:[Int], _ direction:String) -> [Int] {
    var list = numbers
    
    if direction == "right" {
        let pop = list.removeLast()
        return [pop] + list
    } else {
        let pop = list.removeFirst()
        return list + [pop]
    }
}