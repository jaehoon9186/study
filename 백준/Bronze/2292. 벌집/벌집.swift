let input = Int(readLine()!)!

var distance = 1
var maxTagetNum = 1
var updateDistance = 0

while true {
    if input <= maxTagetNum {
        print(distance)
        break
    }
    distance += 1
    updateDistance += 6
    maxTagetNum += updateDistance
}
