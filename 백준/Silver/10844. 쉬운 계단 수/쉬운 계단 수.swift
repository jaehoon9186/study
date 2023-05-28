let input = Int(readLine()!)!


func stairsCount(_ count: Int) {

    var dpList: [[Int]] = []
    dpList.append([])
    dpList.append([0,1,1,1,1,1,1,1,1,1])

    if count < 2 {
        print(dpList[count].reduce(0, +))
        return
    }

    for i in 2...count {
        var temp: [Int] = []
        for j in 0..<10 {
            if j == 0 {
                temp.append(dpList[i - 1][j + 1] % 1000000000)
                continue
            }
            if j == 9 {
                temp.append(dpList[i - 1][j - 1] % 1000000000)
                break
            }
            temp.append((dpList[i - 1][j - 1] + dpList[i - 1][j + 1]) % 1000000000)
        }

        dpList.append(temp)
    }


    print(dpList[count].reduce(0, +) % 1000000000)

}


stairsCount(input)
