import Foundation

func solution(_ i:Int, _ j:Int, _ k:Int) -> Int {
    return (i...j).map { String($0) }.joined().filter { String(k).contains($0) }.count
}