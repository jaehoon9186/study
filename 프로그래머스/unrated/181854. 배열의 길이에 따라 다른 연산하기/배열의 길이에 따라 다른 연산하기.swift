import Foundation

func solution(_ arr:[Int], _ n:Int) -> [Int] {
    return arr.enumerated().map {
        arr.count % 2 == 0 ?
        ( $0 % 2 == 1 ? $1 + n : $1 ) :
        ( $0 % 2 == 0 ? $1 + n : $1 )
    }
}