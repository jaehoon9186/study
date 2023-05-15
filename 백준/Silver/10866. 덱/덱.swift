// 더블

struct Deque {
    private var frontStack: [Int] = []
    private var backStack: [Int] = []

    var size: Int {
        return frontStack.count + backStack.count
    }

    var dequeIsEmpty: Bool {
        return frontStack.isEmpty && backStack.isEmpty
    }

    mutating func pushFront(_ element: Int) {
        frontStack.append(element)
    }

    mutating func pushBack(_ element: Int) {
        backStack.append(element)
    }

    mutating func popFront() -> Int? {
        if frontStack.isEmpty {
            frontStack = backStack.reversed()
            backStack.removeAll()
        }
        return frontStack.popLast()
    }

    mutating func popBack() -> Int? {
        if backStack.isEmpty {
            backStack = frontStack.reversed()
            frontStack.removeAll()
        }
        return backStack.popLast()
    }

    mutating func front() -> Int? {
        if frontStack.isEmpty {
            frontStack = backStack.reversed()
            backStack.removeAll()
        }
        return frontStack.last
    }

    mutating func back() -> Int? {
        if backStack.isEmpty {
            backStack = frontStack.reversed()
            frontStack.removeAll()
        }
        return backStack.last
    }
}

let t = Int(readLine()!)!
var deQ = Deque()

for _ in 0..<t {
    let input = readLine()!.split(separator: " ")

    switch input[0] {
    case "push_front":
        deQ.pushFront(Int(input[1])!)
    case "push_back":
        deQ.pushBack(Int(input[1])!)
    case "pop_front":
        print(deQ.popFront() ?? -1)
    case "pop_back":
        print(deQ.popBack() ?? -1)
    case "front":
        print(deQ.front() ?? -1)
    case "back":
        print(deQ.back() ?? -1)
    case "size":
        print(deQ.size)
    case "empty":
        print(deQ.dequeIsEmpty ? 1 : 0)
    default:
        break
    }
}

