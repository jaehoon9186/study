# Queue 구현 using LinkedList

```swift

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
```
