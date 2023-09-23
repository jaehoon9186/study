import Foundation

func solution(_ lines:[[Int]]) -> Int {
    
    var dict: [Int: Int] = [:]
    
    for i in (-100...100) {
        dict[i, default: 0] = 0
    }
    
    for i in lines {
        for j in i[0]..<i[1] {
            dict[j]! += 1
        }
    }
    
    return dict.filter { $1 >= 2 }.count
}