import Foundation

func solution(_ info:[String], _ query:[String]) -> [Int] {
    
    let applicants = info.map { $0.split(separator: " ").map { String($0) } }
    let querys = query.map { String($0.replacingOccurrences(of: " and ", with: " ")).split(separator: " ").map { String($0) } }
    let dict: [String: Int] = [
        "-": 0, "cpp": 27 * 1, "java": 27 * 2, "python": 27 * 3,
        "backend": 9 * 1, "frontend": 9 * 2,
        "junior": 3 * 1, "senior": 3 * 2,
        "chicken": 1, "pizza": 2 
    ]
    var allAplicant = Array(repeating: Array<Int>(), count: 4 * 3 * 3 * 3)
    var result: [Int] = []

    
    for i in applicants {
        let temp = i
        let point = Int(temp[4])!
        
        for j in 0..<(1<<4) {  
            var index = 0 
            for k in 0..<4 {
                if j & (1<<k) != 0 {
                    index += dict[temp[k]]!
                } 
            }
            allAplicant[index].append(point)
        }
    }
    
    allAplicant = allAplicant.map { $0.sorted(by: <) }
    
    for i in querys { 
        let index = dict[i[0]]! + dict[i[1]]! + dict[i[2]]! + dict[i[3]]!
        let pointList = allAplicant[index]
        let target = Int(i[4])!
        var targetIndex = binarySearch(pointList, 0, pointList.count - 1, target)
        
        // 중복 값이 있을때의 인덱스 처리
        while pointList.count > targetIndex && targetIndex > 0 {
            if pointList[targetIndex] == pointList[targetIndex - 1] {
                targetIndex -= 1
            } else {
                break
            }
        }
        
        result.append(pointList[targetIndex...].count)
    }
    
    return result
}

func binarySearch(_ list: [Int], _ start: Int, _ end: Int, _ target: Int) -> Int {
    if start > end {
        return start
    }
    let mid = (start + end) / 2

    if list[mid] == target {
        return mid
    } else if list[mid] > target {
        return binarySearch(list, start, mid - 1, target)
    } else {
        return binarySearch(list, mid + 1, end, target)
    }
}