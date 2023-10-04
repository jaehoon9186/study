import Foundation

func solution(_ dot:[Int]) -> Int {
    let (a, b) = (dot[0], dot[1])
    
    if a >= 0 {
        if b >= 0 {
            return 1
        } else {
            return 4
        }
    } else {
        if b >= 0 {
            return 2
        } else {
            return 3
        }
    }
    
}