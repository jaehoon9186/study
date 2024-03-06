
class Queue {
    private var list: [Int] = []

    var size: Int {
        return list.count
    }

    var isEmpty: Bool {
        return list.isEmpty
    }

    init() {
    }

    func push(value: Int) {
        list.append(value)
    }

    func getFront() -> Int? {
        return list.first
    }

    func getBack() -> Int? {
        return list.last
    }

    func pop() -> Int? {
        var reversed: [Int] = list.reversed()
        let result = reversed.popLast()
        list = reversed.reversed()
        return result
    }
    
}

let n = Int(readLine()!)!

let q = Queue()

for _ in 0..<n {
    let input = readLine()!.split(separator: " ")
    switch input[0] {
    case "push":
        q.push(value: Int(input[1])!)
    case "pop":
        if let pop = q.pop() {
            print(pop)
        } else {
            print(-1)
        }
    case "size":
        print(q.size)
    case "empty":
        print(q.isEmpty ? 1 : 0)
    case "front":
        if let front = q.getFront() {
            print(front)
        } else {
            print(-1)
        }
    default:
        if let back = q.getBack() {
            print(back)
        } else {
            print(-1)
        }

    }
 }
