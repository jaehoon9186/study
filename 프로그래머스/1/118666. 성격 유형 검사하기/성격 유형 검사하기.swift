import Foundation

func solution(_ survey:[String], _ choices:[Int]) -> String {
    var result = ""
    var score: [String: Int] = [
        "R": 0, "T": 0, "C": 0, "F": 0,
        "J": 0, "M": 0, "A": 0, "N": 0
    ]
    
    for i in zip(survey, choices) {
        let temp = i.0.map { String($0) }
        let (first, second) = (temp[0], temp[1])
        let scoreDiff = i.1 - 4 
        
        if scoreDiff > 0 {
            score[second]! += scoreDiff
        } else if scoreDiff < 0 {
            score[first]! += abs(scoreDiff)
        }
        
    }
    
    for i in zip(["R", "C", "J", "A"], ["T", "F", "M", "N"]) {
        result += score[i.0]! >= score[i.1]! ? i.0 : i.1
    }
    
    
    return result
}