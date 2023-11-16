import Foundation

func solution(_ cap:Int, _ n:Int, _ deliveries:[Int], _ pickups:[Int]) -> Int64 {
    
    var deliveries = deliveries
    var pickups = pickups
    var distance = (1...n).map { Int($0) }
    
    var d = 0
    var p = 0
    var result = 0
    
    while deliveries.count > 0 && pickups.count > 0 {
        let dis = distance.removeLast()
        d += deliveries.removeLast()
        p += pickups.removeLast()
        
        while d > 0 || p > 0 {
            d -= cap
            p -= cap
            result += dis
        }
    }
    
    return Int64(result * 2)
}