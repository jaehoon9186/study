import Foundation

func solution(_ binomial:String) -> Int {
    let temp = binomial.split(separator: " ")
    let (a, op, b) = (Int(temp[0])!, String(temp[1]), Int(temp[2])!)
    
    switch op {
        case "*":
            return a * b
        case "-":
            return a - b
        default:
            return a + b
    }
}