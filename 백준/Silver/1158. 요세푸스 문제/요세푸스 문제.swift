class Node {
    var prev: Node?
    var value: Int
    var next: Node?

    init(prev: Node? = nil, value: Int, next: Node? = nil) {
        self.prev = prev
        self.value = value
        self.next = next
    }
}

class CircleLinkedList {

    var head: Node?

    var isEmpty: Bool {
        return head == nil
    }

    init(count: Int) {
        var currNode = Node(value: 1)
        head = currNode

        for _ in 0..<count - 1 {
            currNode.next = Node(prev: currNode, value: currNode.value + 1)
            currNode = currNode.next!
        }
        currNode.next = head
        head?.prev = currNode
    }

    func removeHead() -> Int? {
        if isEmpty {
            return nil
        }


        let value = head?.value

        let prevNode = head?.prev
        let nextNode = head?.next

        prevNode?.next = nextNode
        nextNode?.prev = prevNode
        head = nextNode

        return value
    }

    func moveHead(number: Int) {
        if isEmpty {
            return
        }

        for _ in 0..<number {
            head = head?.next
        }
    }

}


var input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, k) = (input[0], input[1])

let linkedList = CircleLinkedList(count: n)
var result: [Int] = []



while result.count < n {
    linkedList.moveHead(number: k - 1)
    if let temp = linkedList.removeHead() {
        result.append(temp)
    }
}

print("<\(result.map { String($0) }.joined(separator: ", "))>")
