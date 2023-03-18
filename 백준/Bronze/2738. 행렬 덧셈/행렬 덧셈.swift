let nm = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (nm[0], nm[1])
var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: m), count: n)
var nums1: [[Int]] = []
var nums2: [[Int]] = []

for _ in (0..<n) {
    let tempArr: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
    nums1.append(tempArr)
}

for _ in (0..<n) {
    let tempArr: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
    nums2.append(tempArr)
}

for i in (0..<n) {
    for j in (0..<m) {
        answer[i][j] = nums1[i][j] + nums2[i][j]
    }
}

for i in (0..<n) {
    print(answer[i].map { String($0) }.joined(separator: " "))
}

