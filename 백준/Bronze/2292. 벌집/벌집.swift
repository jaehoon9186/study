let input = Int(readLine()!)!

func getDistance(a: Int) {
    var distance = 2
    var maxTagetNum = 7
    var updateDistance = 6

    if a == 1 {
        print("1")
        return
    }

    while true {
        if a <= maxTagetNum {
            print(distance)
            break
        }
        distance += 1
        updateDistance += 6
        maxTagetNum += updateDistance
    }
}

getDistance(a: input)
