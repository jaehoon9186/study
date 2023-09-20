import Foundation

func solution(_ num_list:[Int], _ n:Int) -> Int {
    return num_list.filter{ $0 == n }.count > 0 ? 1 : 0
}