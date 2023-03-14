let input = Int(readLine()!)!

let iter = 0..<(input * 2 - 1)
var starCount = -1
var blankCount = input

iter.forEach {
    if $0 <= iter.count / 2 {
        starCount += 2
        blankCount -= 1
    } else {
        starCount -= 2
        blankCount += 1
    }
    print("\(String(repeating: " ", count: blankCount))\(String(repeating: "*", count: starCount))")
}
