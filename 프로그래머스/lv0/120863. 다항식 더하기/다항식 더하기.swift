import Foundation

func solution(_ polynomial:String) -> String {
    
    let all = polynomial.components(separatedBy: " + ")
    let a = all.filter { $0.contains("x") }.map { $0.count > 1 ? Int($0.dropLast(1))! : 1 }.reduce(0, +)
    let b = all.filter { $0.contains("x") == false }.map { Int($0)! }.reduce(0, +)
    
    let aString = a > 0 ? (a == 1 ? "x" : String(a) + "x" ) : ""
    let middle = a > 0 && b > 0 ? " + " : ""
    let bString = b > 0 ? String(b) : ""
    
    return aString + middle + bString
}