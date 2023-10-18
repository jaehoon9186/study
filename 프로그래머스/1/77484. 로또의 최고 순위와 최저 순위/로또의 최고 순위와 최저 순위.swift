import Foundation

func solution(_ lottos:[Int], _ win_nums:[Int]) -> [Int] {
    
    let rank: [Int: Int] = [6:1, 5:2, 4:3, 3:4, 2:5, 1:6, 0:6]
    let zeroCount = lottos.filter { $0 == 0 }.count
    var lotCount = 0
    
    for i in win_nums {
        if lottos.contains(i) {
            lotCount += 1
        }
    }
    
    return [rank[min(lotCount + zeroCount, 6)]!, rank[lotCount]!]
}