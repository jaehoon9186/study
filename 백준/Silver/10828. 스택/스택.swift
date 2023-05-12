struct Stack {
    private var stack: [Int] = []

    public var count: Int {
        return stack.count
    }

    public var isEmpty: Bool {
        return stack.isEmpty
    }

    public mutating func push(_ element: Int) {
        stack.append(element)
    }

    public mutating func pop() -> Int? {
        return isEmpty ? -1 : stack.popLast()
    }

    public func isTopNumber() -> Int? {
        return isEmpty ? -1 : stack.last
    }

    public func isEmptyFunc() -> Int {
        return isEmpty ? 1 : 0
    }
}

let t = Int(readLine()!)!
var s = Stack()

for _ in 0..<t {
    let input = readLine()!.split(separator: " ")

    switch input[0] {
    case "push":
        s.push(Int(input[1])!)
    case "pop":
        print(s.pop()!)
    case "size":
        print(s.count)
    case "empty":
        print(s.isEmptyFunc())
    case "top":
        print(s.isTopNumber()!)
    default:
        print("")
    }

}
