import Foundation

func solution(_ balls:Int, _ share:Int) -> Int {
    
    let result = fac(balls) / ( fac(balls - share) * fac(share) )
    
    return (result as NSDecimalNumber).intValue
}


func fac(_ num: Int) -> Decimal {
    var result: Decimal = Decimal(1)
    
    if num < 1 {
        return result
    }
    
    for i in 1...num {
        result *= Decimal(i)
    }
    
    return result
}