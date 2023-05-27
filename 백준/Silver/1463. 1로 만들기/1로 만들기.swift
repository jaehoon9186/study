let input = Int(readLine()!)!

func minCalculationCount(_ num: Int) {

    if num < 2 {
        print(0)
        return
    }

    var dplist: [Int] = []
    dplist.append(0) // 0
    dplist.append(0) // 1


    for i in 2...num {
        var minCal = Int.max
        if i % 3 == 0 {
            minCal = min(minCal, dplist[i / 3])
        }
        if i % 2 == 0 {
            minCal = min(minCal, dplist[i / 2])
        }
        minCal = min(minCal, dplist[i - 1])
        dplist.append(minCal + 1)
    }

    print(dplist[input])
}

minCalculationCount(input)

