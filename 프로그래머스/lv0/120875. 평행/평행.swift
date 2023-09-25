import Foundation

func solution(_ dots:[[Int]]) -> Int {
    
    var all: [Double] = []
    
    for i in 0..<dots.count - 1 {
        for j in (i + 1)..<dots.count {
            var xs = Double(dots[i][0] - dots[j][0])
            var ys = Double(dots[i][1] - dots[j][1])
            let diff = ys / xs
    
            all.append(diff)
        }
    }
    
    for i in 0..<all.count / 2 {
        if all[i] == all[all.count - i - 1] {
            return 1
        }
    }
    
    
    return 0
}