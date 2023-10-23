# swift heap 구현해보기. 

maxheap만 구현해 보았다. 

heap?   
완전 이진트리기반,  
minheap과 maxheap이 있으며, maxheap의 경우 부모노드가 자식노드보다 큰 값을 가진다. minheap의 경우는 반대.  
삽입, 삭제 O(logN)  

우선순위 큐(priority queue) 구현을 위해 사용되는 data structure 중 하나임  
priority queue != Heap  
priority queue = ADT (Abstract data type, 추상 자료형)  
heap = data structrue  


```swift
// heap 구현
// insert: 삽입
// delete: 가장 큰 값 추출, 삭제
// peek: 가장 큰 값 추출

struct MaxHeap<T: Comparable> {
    var elements: Array<T> = []


    func peek() -> T? {
        return elements.first
    }

    mutating func insert(_ data: T) {
        elements.append(data)
        swapUp(elements.count - 1)
    }

    // 0번(큰 값) 리턴, 이후 가장 큰값을 0번 인덱스에 위치시키기 위해 스왑.
    mutating func delete() -> T? {
        if elements.count <= 0 {
            return nil
        }

        elements.swapAt(0, elements.count - 1)
        let returnValue = elements.popLast()
        swapDown(0)
        return returnValue
    }

    // 부모노드가 더 작으면 swap
    mutating private func swapUp(_ insertIndex: Int) {
        var index = insertIndex

        while index > 0 && elements[index] > elements[(index - 1) / 2] {
            elements.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }

    mutating private func swapDown(_ index: Int) {
        var swapIndex = index
        let leftIndex = index * 2 + 1
        let rightIndex = index * 2 + 2
        var isSwap = false

        if leftIndex < elements.count && elements[leftIndex] > elements[swapIndex] {
            isSwap = true
            swapIndex = leftIndex
        }

        if rightIndex < elements.count && elements[rightIndex] > elements[swapIndex] {
            isSwap = true
            swapIndex = rightIndex
        }

        if isSwap {
            elements.swapAt(index, swapIndex)
            swapDown(swapIndex)
        }

    }

}
```
