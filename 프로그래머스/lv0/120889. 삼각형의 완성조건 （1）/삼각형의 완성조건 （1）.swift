import Foundation

func solution(_ sides:[Int]) -> Int {
    let sortedSides = sides.sorted()
    
    return sortedSides[2] < sortedSides[0] + sortedSides[1] ? 1 : 2
}