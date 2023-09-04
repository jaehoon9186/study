import Foundation

func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var result: [Int] = []
    
    for q in queries {
        let (s, e, k) = (q[0], q[1], q[2])
        
        if let a = arr[s...e].filter { $0 > k }.min() {
            result.append(a)
        } else {
            result.append(-1)
        }
    }
    return result
}