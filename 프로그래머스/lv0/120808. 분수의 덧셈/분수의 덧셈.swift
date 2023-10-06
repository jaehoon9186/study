import Foundation

func solution(_ numer1:Int, _ denom1:Int, _ numer2:Int, _ denom2:Int) -> [Int] {
    var result = [numer1 * denom2 + numer2 * denom1, denom1 * denom2]
    let gcdNum = gcd(result.max()!, result.min()!)
    
    return result.map { $0 / gcdNum }
}

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }

    return gcd(b, a % b)
}