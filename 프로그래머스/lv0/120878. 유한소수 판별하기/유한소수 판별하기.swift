import Foundation

func solution(_ a:Int, _ b:Int) -> Int {
    
    let gcdNum = gcd(b, a)
    
    var temp = b / gcdNum
    var insu = 2
    var list = Set<Int>()
    
    while temp > 1 {
        if temp % insu == 0 {
            list.insert(insu)
            temp /= insu
        } else {
            insu += 1
        }
    }
    
    
    return list.isSubset(of: Set([2, 5])) ? 1 : 2
}

func gcd(_ p: Int, _ q: Int) -> Int {
    if q == 0 {
        return p
    }
    
    return gcd(q, p % q)
}