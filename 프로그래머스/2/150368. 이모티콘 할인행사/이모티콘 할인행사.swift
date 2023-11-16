import Foundation

func solution(_ users:[[Int]], _ emoticons:[Int]) -> [Int] {
    
    var paidMember = 0
    var income = 0
    
    let sale = perm(emoticons.count, [40, 30, 20, 10])

    for i in sale {
        var tempPaidMember = 0
        var tempIncome = 0
        
        for user in users {
            let buyPercent = user[0]
            var money = user[1]
            var totalPrice = 0
            
            for percentAndCost in zip(i, emoticons) {
                let percent = percentAndCost.0
                
                // 할인율 낮음 안산다. 
                if percent < buyPercent {
                    continue
                }
                
                // 산다.
                let price = (percentAndCost.1 * (100 - percent)) / 100
                totalPrice += price
            }
            
            // 유료회원 가입함.
            if totalPrice >= money {
                tempPaidMember += 1
            } else { // 가입 안함
                tempIncome += totalPrice
            }
            
        }
        
        if tempPaidMember > paidMember {
            paidMember = tempPaidMember
            income = tempIncome
            continue
        }
        if tempPaidMember < paidMember {
            continue
        }
        if tempIncome > income {
            income = tempIncome
        }
    }
    
    return [paidMember, income]
}

func perm(_ n: Int, _ list: [Int]) -> [[Int]] {
    var result: [[Int]] = []
    
    func getPerm(_ r: Int, _ output: [Int] = []) {
        var output = output
        
        if output.count == r {
            result.append(output)
            return
        }
    
        for i in 0..<list.count {
            output.append(list[i])
            getPerm(r, output)
            output.removeLast()
        }
        
    }
    
    getPerm(n)
    
    return result
}