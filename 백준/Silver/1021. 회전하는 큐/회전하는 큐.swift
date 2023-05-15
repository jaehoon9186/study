
struct Deque {
    private var frontStack: [Int] = []
    private var backStack: [Int] = []

    var size: Int {
        return frontStack.count + backStack.count
    }

    var dequeIsEmpty: Bool {
        return frontStack.isEmpty && backStack.isEmpty
    }

    var front: Int? {
        let temp = frontStack.reversed() + backStack
        return temp.first
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

    func rightTagetLenth(_ taget: Int) -> Int {
        let temp = frontStack.reversed() + backStack
        var len = 0
        for i in temp {
            if i == taget {
                break
            }
            len += 1
        }

        return len
    }

    func leftTagetLenth(_ taget: Int) -> Int {
        let temp = frontStack.reversed() + backStack
        var len = 0
        for i in temp.reversed() {
            if i == taget {
                break
            }
            len += 1
        }

        return len
    }

    var q: [Int] {
        return frontStack.reversed() + backStack
    }

}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, _) = (input[0], input[1])
let tagetList = readLine()!.split(separator: " ").map { Int($0)! }
var result = 0

var deQ = Deque()

for i in 1...n {
    deQ.pushBack(i)
}

for taget in tagetList {
    var flag = 0 // 0: 왼쪽, 1: 오른쪽
    // if 오른쪽으로 회전
    if deQ.rightTagetLenth(taget) > deQ.leftTagetLenth(taget) {
        flag = 1
    }

    while deQ.front != taget {
        switch flag {
        case 0:
            deQ.pushBack(deQ.popFront()!)
        case 1:
            deQ.pushFront(deQ.popBack()!)
        default:
            break
        }
        result += 1
    }

    _ = deQ.popFront()

}

print(result)
