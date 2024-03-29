import Foundation

func solution(_ sticker:[Int]) -> Int{
    
    let size = sticker.count
    
     if size < 3 {
        return sticker.max()!
    }
    
    // dp1, 0번선택 / dp2, 1번 선택
    var dp1 = Array(repeating: 0, count: size)
    var dp2 = Array(repeating: 0, count: size)
    
    dp1[0] = sticker[0]
    dp1[1] = sticker[0]
    
    dp2[1] = sticker[1]
    
    for i in 2..<size {
        dp1[i] = max(dp1[i-1], sticker[i] + dp1[i-2])
        dp2[i] = max(dp2[i-1], sticker[i] + dp2[i-2])
    }
    
    return max(dp1[size - 2], dp2[size - 1])
}