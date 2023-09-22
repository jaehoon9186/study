import Foundation

func solution(_ score:[[Int]]) -> [Int] {
    
    var result = Array(0..<score.count)
    
    let sortedRank = score.enumerated()
    .sorted { 
        $0.element[0] + $0.element[1] > $1.element[0] + $1.element[1] }
    .map { $0.element }
    
    var preScore = [110, 110]
    var preRank = 0
    
    for i in sortedRank.enumerated() {
        // 랭킹 
        var rank = 0
        
        if i.element.reduce(0, +) == preScore.reduce(0, +) {
            rank = preRank
        } else {
            rank = i.offset + 1
            preRank = rank
            preScore = i.element
        }
        
        //인덱스 찾기
        if let idx = score.firstIndex(of: i.element) {
            result[idx] = rank
        }
    }
    
    return result
}