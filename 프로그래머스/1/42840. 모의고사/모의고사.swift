import Foundation

func solution(_ answers:[Int]) -> [Int] {
    
    let person1 = [1, 2, 3, 4, 5]
    let person2 = [2, 1, 2, 3, 2, 4, 2, 5]
    let person3 = [3, 3, 1, 1, 2, 2, 4, 4, 5, 5]
    let len1 = person1.count
    let len2 = person2.count
    let len3 = person3.count
    
    var count = [0, 0, 0]
    
    for i in 0..<answers.count {
        if answers[i] == person1[i % len1] {
            count[0] += 1
        }
        
        if answers[i] == person2[i % len2] {
            count[1] += 1
        }
        
        if answers[i] == person3[i % len3] {
            count[2] += 1
        }
    }
    
    let max = count.max()!
    
    if max == 0 {
        return []
    }
    
    return count.enumerated().filter { $0.1 == max }.map { $0.offset + 1 }
}