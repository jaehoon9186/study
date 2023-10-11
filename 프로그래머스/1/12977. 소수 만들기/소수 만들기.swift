import Foundation

func solution(_ nums:[Int]) -> Int {
    var answer = 0
    let sorted = nums.sorted()
    var list = Array(repeating: true, count: sorted[(sorted.count - 3)...].reduce(0, +) + 1)
    list[0] = false
    list[1] = false
    
    for (i, v) in list.enumerated() {
        if v {
            for j in stride(from: i + i, to: list.count, by: i) {
                list[j] = false
            }
        }
    }
    let primeList = list.enumerated().filter { $1 }.map { $0.offset }

    for i in 0..<nums.count - 2 {
        for j in i + 1..<nums.count - 1 {
            for k in j + 1..<nums.count {
                let s = nums[i] + nums[j] + nums[k]
                if primeList.contains(s) {
                    answer += 1
                }
            }
        }
    }

    return answer
}
