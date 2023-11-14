import Foundation

func solution(_ n:Int, _ left:Int64, _ right:Int64) -> [Int] {
    
    var numbers = (1...n).map { $0 }
    var result: [Int] = []
    
    var temp = 0
    
    for i in Int(left)...Int(right) {
        let (moc, na) = (i/n, i%n)
        
        if temp != moc {
            for j in (0..<moc).reversed() {
                numbers[j] = numbers[moc]
            }
            temp = moc
        }
                  
        result.append(numbers[na])
    }
    
    return result
}