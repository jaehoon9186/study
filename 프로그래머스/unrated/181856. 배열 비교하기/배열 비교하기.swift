import Foundation

func solution(_ arr1:[Int], _ arr2:[Int]) -> Int {
    
    let arr1Count = arr1.count
    let arr2Count = arr2.count
    let arr1Sum = arr1.reduce(0, +)
    let arr2Sum = arr2.reduce(0, +)
    
    if arr1Count > arr2Count {
        return 1
    } else if arr1Count < arr2Count {
        return -1
    }
    
    if arr1Sum > arr2Sum {
        return 1
    } else if arr1Sum < arr2Sum {
        return -1
    } else {
        return 0
    }
}