import Foundation

func solution(_ slice:Int, _ n:Int) -> Int {
    
    var c = 1 
    
    while slice * c < n {
        c += 1
    }
    
    return c
}