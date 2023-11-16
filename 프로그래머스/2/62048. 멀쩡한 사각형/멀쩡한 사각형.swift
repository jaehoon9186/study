import Foundation

func solution(_ w:Int, _ h:Int) -> Int64{
    
    var tempW = max(w, h)
    var temph = min(w, h)
    let gcdNum = gcd(w, h)
    
    tempW /= gcdNum
    temph /= gcdNum
    
    var whiteBox = tempW * temph - ((tempW - 1) * (temph - 1))
    
    return Int64(w * h - whiteBox * gcdNum)
}

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }
    
    return gcd(b, a % b)
}

// 최대 공약수 구하기 