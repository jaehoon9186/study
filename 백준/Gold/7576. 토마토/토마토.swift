
class Node<T> {
    var value: T
    var next: Node?

    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

class Queue<T> {

    private var head: Node<T>?
    private var tail: Node<T>?

    var isEmpty: Bool {
        return head == nil
    }

    init() {
    }

    func enqueue(value: T) {
        let newNode = Node(value: value)
        if isEmpty {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            tail = newNode
        }
    }

    func dequeue() -> T? {
        let value = head?.value

        head = head?.next

        if head == nil {
            tail = nil
        }

        return value
    }

}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (m, n) = (input[0], input[1])

var box: [[Int]] = []
var dx = [0, 0, 1, -1]
var dy = [1, -1, 0, 0]
//var stack: [[Int]] = []
var queue = Queue<[Int]>()

for _ in 0..<n {
    box.append(readLine()!.split(separator: " ").map { Int($0)! } )
}

for i in 0..<n {
    for j in 0..<m {
        if box[i][j] == 1 {
//            stack.append([i, j])
            queue.enqueue(value: [i, j])
        }
    }
}

while queue.isEmpty == false {
    guard let pop = queue.dequeue() else {
        break
    }
    for i in 0..<4 {
        let nextX = pop[0] + dx[i]
        let nextY = pop[1] + dy[i]

        if nextX < 0 || nextX >= n || nextY < 0 || nextY >= m {
            continue
        }

        if box[nextX][nextY] == 0 {
            box[nextX][nextY] = box[pop[0]][pop[1]] + 1
            queue.enqueue(value: [nextX, nextY])
            continue
        }
    }
}


let flatMap = box.flatMap { $0 }

if flatMap.contains(0) {
    print(-1)
} else {
    print(flatMap.max()! - 1)
}
