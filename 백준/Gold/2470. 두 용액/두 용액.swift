let n = Int(readLine()!)!

let list = readLine()!.split(separator: " ").map { Int($0)! }.sorted()


var lHand = 0
var rHand = n - 1

var min = Int.max
var result = [0, 0]

while lHand < rHand {
    var hap = list[lHand] + list[rHand]

    if min > abs(hap) {
        min = abs(hap)
        result = [list[lHand], list[rHand]]
    }

    if hap == 0 {
        break
    }

    if hap < 0 {
        lHand += 1
    } else {
        rHand -= 1
    }

}


print(result.map { String($0) }.joined(separator: " "))