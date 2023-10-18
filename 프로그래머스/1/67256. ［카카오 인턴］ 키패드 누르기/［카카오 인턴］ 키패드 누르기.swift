import Foundation

func solution(_ numbers:[Int], _ hand:String) -> String {
    
    let keypad: [String: (Int, Int)] = [
        "1": (0, 0), "2": (0, 1), "3": (0, 2),
        "4": (1, 0), "5": (1, 1), "6": (1, 2),
        "7": (2, 0), "8": (2, 1), "9": (2, 2),
        "*": (3, 0), "0": (3, 1), "#": (3, 0)
    ]
    
    var result = ""
    var lHand = "*"
    var rHand = "#"
    
    for i in numbers {
        
        if [1, 4, 7].contains(i) {
            result += "L"
            lHand = String(i)
            continue
        } else if [3, 6, 9].contains(i) {
            result += "R"
            rHand = String(i)
            continue
        }
        
        guard let key = keypad[String(i)], let lPos = keypad[lHand], let rPos = keypad[rHand] else {
            break
        }
        
        let lDiff = abs(key.0 - lPos.0) + abs(key.1 - lPos.1)
        let rDiff = abs(key.0 - rPos.0) + abs(key.1 - rPos.1)
        
        if lDiff < rDiff {
            result += "L"
            lHand = String(i)
        } else if lDiff > rDiff {
            result += "R"
            rHand = String(i)
        } else {
            if hand == "right" {
                result += "R"
                rHand = String(i)
            } else {
                result += "L"
                lHand = String(i)
            }
        }
    }
    
    return result
}