let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, k) = (input[0], input[1])
var wList: [Int] = [0]
var vList: [Int] = [0]
var dpTable: [Int] = Array(repeating: 0, count: k + 1)

for _ in 0..<n {
    let input2 = readLine()!.split(separator: " ").map { Int($0)! }
    let (w, v) = (input2[0], input2[1])
    wList.append(w)
    vList.append(v)
}


for i in 1...n {
    for j in stride(from: k, to: 0, by: -1) {
        if wList[i] + j > k {
            continue
        }
        if dpTable[j] == 0 {
            continue
        }
        dpTable[wList[i] + j] = max(dpTable[wList[i] + j], vList[i] + dpTable[j])
    }
    if wList[i] <= k {
        dpTable[wList[i]] = max(vList[i], dpTable[wList[i]])
    }
}

print(dpTable.max()!)
