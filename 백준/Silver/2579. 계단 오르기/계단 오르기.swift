let t = Int(readLine()!)!
var stairs: [Int] = []
var dpList: [[Int]] = []

for _ in 0..<t {
    let input = Int(readLine()!)!
    stairs.append(input)
}

func stairsCount(_ count: Int, _ arr: [Int]) {
    var dpList: [[Int]] = []

    if count == 1 {
        print(arr[0])
        return
    }

    // dplist [[0번, 1번], []]
    // *0번: 이전칸과 연속으로 밟은 경우의 합
    // *1번: 두칸을 건너온 경우의 합, max(a: *0번 이후 두칸, b: *1번 이후 두칸 )
    dpList.append([0, arr[0]])
    dpList.append([arr[0] + arr[1], arr[1]])


    for i in 2..<count {
        var temp: [Int] = []
        temp.append(arr[i] + dpList[i - 1][1])
        temp.append(max(arr[i] + dpList[i - 2][0], arr[i] + dpList[i - 2][1]))
        dpList.append(temp)
    }

    if let maxNum = dpList[count - 1].max() {
        print(maxNum)
    }
}

stairsCount(t, stairs)









