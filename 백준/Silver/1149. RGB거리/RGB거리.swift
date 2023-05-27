let t = Int(readLine()!)!
var rgbList: [[Int]] = []
var dpList: [[Int]] = []

for _ in 0..<t {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    rgbList.append(input)
}

dpList.append(rgbList[0])

for i in 1..<t {
    var temp: [Int] = []

    temp.append(min(rgbList[i][0] + dpList[i - 1][1], rgbList[i][0] + dpList[i - 1][2]))
    temp.append(min(rgbList[i][1] + dpList[i - 1][0], rgbList[i][1] + dpList[i - 1][2]))
    temp.append(min(rgbList[i][2] + dpList[i - 1][0], rgbList[i][2] + dpList[i - 1][1]))

    dpList.append(temp)

}

if let endPrices = dpList.last, let minPrice = endPrices.min() {
    print(minPrice)
}
