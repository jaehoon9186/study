import Foundation

let t = Int(readLine()!)!

for _ in 0..<t {
    let acList = Array(readLine()!)
    let n = Int(readLine()!)!
    let numberList = readLine()!.trimmingCharacters(in: ["[", "]"]).split(separator: ",").map { Int($0)! }
    var reverse: Bool = false

    var (lHand, rHand) = (0, n - 1)

    for i in acList {
        switch i {
        case "R":
            reverse.toggle()
        case "D":
            if reverse == false {
                lHand += 1
            } else {
                rHand -= 1
            }
        default:
            break
        }
    }


    if lHand - rHand >= 2 {
        print("error")
        continue
    }

    if lHand - rHand == 1 {
        print("[]")
        continue
    }

    var temp = Array(numberList[lHand...rHand])
    if reverse {
        temp = temp.reversed()
    }
    print("[\(temp.map { String($0) }.joined(separator: ","))]")

}

