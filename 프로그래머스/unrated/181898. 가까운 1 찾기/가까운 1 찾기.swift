import Foundation

func solution(_ arr:[Int], _ idx:Int) -> Int {
    
    if let a = arr[idx...].firstIndex(of: 1) {
        return a
    } else {
        return -1
    }

}