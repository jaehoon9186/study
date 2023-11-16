import Foundation

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
    
    var queue1 = queue1
    var queue2 = queue2
    var queue1Sum = queue1.reduce(0, +)
    var queue2Sum = queue2.reduce(0, +)
    let hap = queue1Sum + queue2Sum
    
    if hap % 2 == 1 {
        return -1
    }
    
    func getNum(_ index: Int) -> Int {
        if index < maxlen {
            return queue1[index]
        } else {
            return queue2[index - maxlen]
        }
    }

    var count = 0
    let maxlen = queue1.count
    
    var l1 = 0 
    var r1 = maxlen - 1
    
    var l2 = maxlen
    var r2 = maxlen * 2 - 1
    
    while queue1Sum != queue2Sum {
        if count > maxlen * 2 + 1 {
            return -1
        }
        count += 1
        
        if queue1Sum > queue2Sum {
            let temp = getNum(l1)
            l1 = (l1 + 1) % (maxlen * 2)
            r2 = (r2 + 1) % (maxlen * 2)
            queue1Sum -= temp
            queue2Sum += temp
        } else {
            let temp = getNum(l2)
            l2 = (l2 + 1) % (maxlen * 2)
            r1 = (r1 + 1) % (maxlen * 2)
            queue1Sum += temp
            queue2Sum -= temp  
        }
    }
    
    return count
}