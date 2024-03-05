# Doubly LInked List

- [참고](https://medium.com/swiftable/data-structure-in-swift-doubly-linked-list-part-4-e657d09a68e3)

![image](https://github.com/jaehoon9186/study/assets/83233720/08475529-ea56-463e-b2aa-be6f0faab99a)


# Node 정의

```swift

class DoublyNode<T> {
    var prev: DoublyNode?
    var data: T
    var next: DoublyNode?

    init(prev: DoublyNode? = nil, data: T, next: DoublyNode? = nil) {
        self.prev = prev
        self.data = data
        self.next = next
    }
}

```

# 양방향 연결리스트 정의 

```swift
class DoublyLinkedList<T> {
    // head
    // tail
    private var head: DoublyNode<T>?
    private var tail: DoublyNode<T>?

    init() {
        head = nil
        tail = head
    }

    func deleteAll() {
        head = nil
        tail = nil
    }
}
```

# 유용한 get프로퍼티 (isEmpty, forwardValues, backwardValues), 메서드
```swift
    var isEmpty: Bool {
        return head == nil
    }

    // 앞에서 부터 순차 벨류
    var forwardValues: [T]? {
        if isEmpty {
            return nil
        }

        var values: [T] = []
        var currentNode = head
        while currentNode != nil {
            values.append(currentNode!.data)
            currentNode = currentNode?.next
        }
        return values
    }

    var backwardValues: [T]? {
        if isEmpty {
            return nil
        }
        var values: [T] = []
        var currentNode = tail
        while currentNode != nil {
            values.append(currentNode!.data)
            currentNode = currentNode?.prev
        }
        return values
    }

    func getNode(at index: Int) -> DoublyNode<T>? {
        if isEmpty {
            return nil
        }
        if index < 0 {
            return nil
        }

        var currentNode = head
        var currentIndex = 0

        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }

        return currentNode
    }
```

# 링크드리스트에 값추가(push, append, insert)
```swift
    // 앞방향 push
    func push(value: T) {
        if isEmpty {
            head = DoublyNode(data: value)
            tail = head
        } else {
            let newNode = DoublyNode(data: value, next: head)
            head?.prev = newNode
            head = newNode
        }
    }

    // 말단에서 추가
    func append(value: T) {
        if isEmpty {
            tail = DoublyNode(data: value)
            head = tail
        } else {
            let newNode = DoublyNode(prev: tail,data: value)
            tail?.next = newNode
            tail = newNode
        }
    }

    // 특정 인덱스에 삽입
    func insert(value: T, at index: Int) -> Bool {
        let node = DoublyNode(data: value)

        guard let selectedNode = getNode(at: index) else {
            return false
        }

        guard let beforeNode = selectedNode.prev else {
            selectedNode.prev = node
            node.next = selectedNode
            head = node
            return true
        }

        node.next = selectedNode
        selectedNode.prev = node

        node.prev = beforeNode
        beforeNode.next = node

        return true
    }
```

# 지우기 (pop, popLast, removeAt)
```swift
    // pop 앞에서
    func pop() -> T? {
        if isEmpty {
            return nil
        }

        defer {
            if head?.next == nil {
                head = nil
                tail = nil
            } else {
                head = head?.next
                head?.prev = nil
            }
        }

        return head?.data
    }

    func popLast() -> T? {
        if isEmpty {
            return nil
        }
        defer {
            if tail?.prev == nil {
                head = nil
                tail = nil
            } else {
                tail = tail?.prev
                tail?.next = nil
            }
        }
        return tail?.data
    }

    func removeAt(at index: Int) -> T? {
        guard let selectedNode = getNode(at: index) else {
            return nil
        }

        if selectedNode === head {
            return pop()
        }

        if selectedNode === tail {
            return popLast()
        }

        defer {
            let prevNode = selectedNode.prev
            let nextNode = selectedNode.next

            prevNode?.next = nextNode
            nextNode?.prev = prevNode
        }

        return selectedNode.data
    }
```

# 전체
```swift
class DoublyLinkedList<T> {
    // head
    // tail
    private var head: DoublyNode<T>?
    private var tail: DoublyNode<T>?

    var isEmpty: Bool {
        return head == nil
    }

    // 앞에서 부터 순차 벨류
    var forwardValues: [T]? {
        if isEmpty {
            return nil
        }

        var values: [T] = []
        var currentNode = head
        while currentNode != nil {
            values.append(currentNode!.data)
            currentNode = currentNode?.next
        }
        return values
    }

    var backwardValues: [T]? {
        if isEmpty {
            return nil
        }
        var values: [T] = []
        var currentNode = tail
        while currentNode != nil {
            values.append(currentNode!.data)
            currentNode = currentNode?.prev
        }
        return values
    }

    init() {
        head = nil
        tail = head
    }

    func deleteAll() {
        head = nil
        tail = nil
    }

    func getNode(at index: Int) -> DoublyNode<T>? {
        if isEmpty {
            return nil
        }
        if index < 0 {
            return nil
        }

        var currentNode = head
        var currentIndex = 0

        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }

        return currentNode
    }

    // 앞방향 push
    func push(value: T) {
        if isEmpty {
            head = DoublyNode(data: value)
            tail = head
        } else {
            let newNode = DoublyNode(data: value, next: head)
            head?.prev = newNode
            head = newNode
        }
    }

    // 말단에서 추가
    func append(value: T) {
        if isEmpty {
            tail = DoublyNode(data: value)
            head = tail
        } else {
            let newNode = DoublyNode(prev: tail,data: value)
            tail?.next = newNode
            tail = newNode
        }
    }

    // 특정 인덱스에 삽입
    func insert(value: T, at index: Int) -> Bool {
        let node = DoublyNode(data: value)

        guard let selectedNode = getNode(at: index) else {
            return false
        }

        guard let beforeNode = selectedNode.prev else {
            selectedNode.prev = node
            node.next = selectedNode
            head = node
            return true
        }

        node.next = selectedNode
        selectedNode.prev = node

        node.prev = beforeNode
        beforeNode.next = node

        return true
    }

    // pop 앞에서
    func pop() -> T? {
        if isEmpty {
            return nil
        }

        defer {
            if head?.next == nil {
                head = nil
                tail = nil
            } else {
                head = head?.next
                head?.prev = nil
            }
        }

        return head?.data
    }

    func popLast() -> T? {
        if isEmpty {
            return nil
        }
        defer {
            if tail?.prev == nil {
                head = nil
                tail = nil
            } else {
                tail = tail?.prev
                tail?.next = nil
            }
        }
        return tail?.data
    }

    func removeAt(at index: Int) -> T? {
        guard let selectedNode = getNode(at: index) else {
            return nil
        }

        if selectedNode === head {
            return pop()
        }

        if selectedNode === tail {
            return popLast()
        }

        defer {
            let prevNode = selectedNode.prev
            let nextNode = selectedNode.next

            prevNode?.next = nextNode
            nextNode?.prev = prevNode
        }

        return selectedNode.data
    }
}
```
