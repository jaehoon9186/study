import Foundation

func solution(_ numLog:[Int]) -> String {
    
    let wasd: [Int: String] = [1: "w", -1: "s", 10: "d", -10: "a"]
    
    return numLog[1...].indices.map { wasd[numLog[$0] - numLog[$0 - 1]]! }.joined()
}