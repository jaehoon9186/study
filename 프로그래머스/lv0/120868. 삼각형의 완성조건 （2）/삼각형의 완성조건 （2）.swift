import Foundation

func solution(_ sides:[Int]) -> Int {
    
    let sortedSides = sides.sorted()
    let (a, b) = (sortedSides[0], sortedSides[1])
    
    return 2 * a - 1
}