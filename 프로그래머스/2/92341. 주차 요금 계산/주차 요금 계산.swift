import Foundation

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    
    var feePerCar: [Int: Int] = [:]
    let allRecords = records.map { $0.split(separator: " ") }
    var result: [Int] = []
    
    for i in allRecords {
        let (car, inoutSig) = (Int(i[1])!, i[2])
        let time = i[0].split(separator: ":").map { Int($0)! }
        let m = time[0] * 60 + time[1]
        
        feePerCar[car, default: 0] += inoutSig == "IN" ? -m : m
    }
    
    for (k, v) in feePerCar {
        var m = v
        var fee = fees[1]
        if m <= 0 {
            m += 1439
        }
        
        // 기본 시간
        if m <= fees[0] {
            feePerCar[k] = fee
            continue
        }
        
        m -= fees[0]
        var temp = m % fees[2] == 0 ? 0 : 1
        fee += (m / fees[2] + temp) * fees[3]
        
        feePerCar[k] = fee
    }
    
    return feePerCar.sorted { $0.0 < $1.0 }.map { $0.value }
}

