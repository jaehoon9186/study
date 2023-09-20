import Foundation

func solution(_ rank:[Int], _ attendance:[Bool]) -> Int {
    
    let pass = zip((0..<rank.count), attendance).filter { $1 }.sorted { rank[$0.0] < rank[$1.0] }.map { $0.0 }
    
    return 10000 * pass[0] + 100 * pass[1] + pass[2]
}