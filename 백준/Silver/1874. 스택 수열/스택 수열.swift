let t = Int(readLine()!)!

var numberList: [Int] = []
var numberListPointer: Int = 0
var result: [String] = []
var stack: [Int] = []

for _ in 0..<t {
    numberList.append(Int(readLine()!)!)
}

for i in 1...t {
    stack.append(i)
    result.append("+")

    while stack.isEmpty == false && stack.last == numberList[numberListPointer] {
        stack.removeLast()
        numberListPointer += 1
        result.append("-")
    }
}

if stack.isEmpty {
    result.forEach {
        print($0)
    }

} else {
    print("NO")
}
