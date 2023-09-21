import Foundation

func solution(_ quiz:[String]) -> [String] {
    var result: [String] = []
    
    for i in quiz {
        let temp = i.split(separator: " ")
        let (a, giho, b, answer) = (Int(temp[0])!, temp[1], Int(temp[2])!, Int(temp[4])!)
        var tempAnswer = 0
        switch giho {
            case "+":
                tempAnswer = a + b
            default :
                tempAnswer = a - b
        }
        result.append(tempAnswer == answer ? "O" : "X")
    }
    
    return result
}