let input = Int(readLine()!)!
var arr: [Int] = []

arr.append(0)
for _ in 0..<input {
    arr.append(Int(readLine()!)!)
}


func maxCount(_ wineList: [Int], _ count: Int) {
    var dpList: [[Int]] = []

    if count < 3 {
        print(wineList.reduce(0, +))
        return
    }
    dpList.append([0, 0])
    dpList.append([wineList[1], 0])
    dpList.append([wineList[2], wineList[1] + wineList[2]])

    for i in 3...count {
        var temp: [Int] = []
        temp.append(wineList[i] + max(dpList[i - 2][0], dpList[i - 2][1], dpList[i - 3][0], dpList[i - 3][1]))
        temp.append(wineList[i] + dpList[i - 1][0])
        dpList.append(temp)
    }

    print(max(dpList[count].max()!, dpList[count - 1].max()!))

}

maxCount(arr, input)
