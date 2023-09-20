
func solution(_ a:Int, _ b:Int) -> Int {
    let isAOdd = a % 2 == 1
    let isBOdd = b % 2 == 1
    
    if isAOdd && isBOdd {
        return a * a + b * b
    } else if isAOdd || isBOdd {
        return 2 * (a + b)
    } else {
        return abs(a - b)
    }
}