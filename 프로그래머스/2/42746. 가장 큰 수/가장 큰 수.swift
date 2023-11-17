import Foundation

func solution(_ numbers:[Int]) -> String {
    var numbersString = numbers.map { String($0) }    
    
    if numbers.max() == 0 {
        return "0"
    }
    
    return numbersString.sorted { String(repeating: $0, count: 3) > String(repeating: $1, count: 3) }.joined() 
}
