struct Queue {
    private var array: [Int?] = []
    private var head: Int = 0

    var size: Int {
        return array.count - head
    }

    var isEmpty: Bool {
        return head == array.count
    }

    mutating func push(_ element: Int) {
        array.append(element)
    }

    mutating func pop() -> Int {
        guard isEmpty == false, let first = array[head] else {
            return 0
        }
        head += 1
        return first
    }

}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, k) = (input[0], input[1])
var q = Queue()
var result: [Int] = []

for i in 1...n {
    q.push(i)
}

while q.size > 1 {
    for _ in 0..<k - 1 {
        q.push(q.pop())
    }
    result.append(q.pop())
}
result.append(q.pop())

print("<\(result.map { String($0) }.joined(separator: ", "))>")

