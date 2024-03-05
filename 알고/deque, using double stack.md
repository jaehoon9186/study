# deque, using double stack

```swift

struct Deque<T> {
    private var frontStack = [T]()
    private var backStack = [T]()

    var isEmpty: Bool {
        return frontStack.isEmpty && backStack.isEmpty
    }

    mutating func pushFront(_ element: T) {
        frontStack.append(element)
    }

    mutating func pushBack(_ element: T) {
        backStack.append(element)
    }

    mutating func popFront() -> T? {
        if frontStack.isEmpty {
            frontStack = backStack.reversed()
            backStack.removeAll()
        }
        return frontStack.popLast()
    }

    mutating func popBack() -> T? {
        if backStack.isEmpty {
            backStack = frontStack.reversed()
            frontStack.removeAll()
        }
        return backStack.popLast()
    }

    func peekFront() -> T? {
        return frontStack.last ?? backStack.first
    }

    func peekBack() -> T? {
        return backStack.last ?? frontStack.first
    }
}

```

양단에서 O(1)의 시간으로 push, pop할수 있는 덱을 구현  
swift에서는 배열 첫번째 인덱스에서 pop하면 O(n) 속도로 pop함. 
[array removeFirst()](https://developer.apple.com/documentation/swift/array/removefirst()) 문서 보면 Complexity O(n).  



<img width="838" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/f2aa1745-dbd6-41e4-984c-d79dfd32bff1">

### 두개의 stack 이용  

앞에서 push, pop하는건 Front stack이용, 뒤에서 push, pop 하는건 back stack 이용.  

만약, pop해야하는디 스택이 빈경우는 반대 스택을 reversed 해서 pop함.
swift에서는 reversed() 메서드가 O(1)로 빠르기때문에 이를 이용한 것. 


