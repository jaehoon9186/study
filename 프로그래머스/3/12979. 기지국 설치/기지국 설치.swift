import Foundation

func solution(_ n:Int, _ stations:[Int], _ w:Int) -> Int{
    var result = 0

    var startOfLeft = 1
    var endOfLeft = 1
    
    let distanceOfStation = 2 * w + 1
    
    // 기지국 사이의 거리를 바탕으로 최소로 필요한 기지국 개수을 구한다. 
    
    for i in stations {
        
        // get range of station
        let s = i - w
        let e = i + w
        
        endOfLeft = s - 1
        
        // check and update result 
        
        if endOfLeft - startOfLeft >= 0 {
            let range = endOfLeft - startOfLeft + 1
            result += getCeilNumAfterDiv(num1: range, num2: distanceOfStation)
        }
        
        // startOfLeft update
        startOfLeft = e + 1
        
    }
    
    // 남은 범위 체크
    if n - startOfLeft >= 0 {
        let range = n - startOfLeft + 1
        result += getCeilNumAfterDiv(num1: range, num2: distanceOfStation)
    }
    
    return result
}

func getCeilNumAfterDiv(num1: Int, num2: Int) -> Int {
    var result = 0
    
    // 몫, 나머지 
    let mok = num1 / num2
    let na = num1 % num2
    
    if na > 0 {
        result += 1
    }
    
    return mok + result
}