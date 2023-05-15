struct Queue {
    private var array: [(Int, Int)?] = []
    private var head: Int = 0

    var size: Int {
        return array.count - head
    }

    var isEmpty: Bool {
        return head == array.count
    }

    mutating func push(_ element: (Int, Int)) {
        array.append(element)
    }

    mutating func pop() -> (Int, Int)? {
        guard isEmpty == false, let first = array[head] else {
            return nil
        }
        head += 1
        return first
    }

    func checkNowPrint() -> Bool {
        var nowImpor = 0

        if let nowImportanceTuple = array[head] {
            nowImpor = nowImportanceTuple.1
        }

        for i in head..<array.count {

            if nowImpor < array[i]!.1 {
                return false
            }

        }
        return true
    }

}

let t = Int(readLine()!)!

for _ in 0..<t {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (_, m) = (input[0], input[1]) // m : target
    let importanceList = readLine()!.split(separator: " ").map { Int($0)! }
    var importanceTuple: [(Int, Int)] = []
    var importanceQueue = Queue()
    var count = 0

    for (i, v) in importanceList.enumerated() {
        importanceTuple.append((i, v))
        importanceQueue.push((i, v))
    }

    while importanceQueue.isEmpty == false {
        let temp: (Int, Int)?

        if importanceQueue.checkNowPrint() == false {
            importanceQueue.push(importanceQueue.pop()!)
            continue
        }

        temp = importanceQueue.pop()!
        count += 1

        if m == temp!.0 {
            print(count)
            break
        }

    }


}
