import Foundation

func solution(_ spell:[String], _ dic:[String]) -> Int {
    
    let spellSet = Set(spell)
    
    for i in dic {
        if Set(i.map { String($0) }) == spellSet {
            return 1
        }
    }
    
    return 2
}