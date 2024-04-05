# binarySearch

O(logN)

```swift
// 정렬된 배열에서 타겟인덱스를 찾음, 못찾으면 -1반환, 
func binarySearch(target: Int, sortedList: [Int]) -> Int {
    
    var left = 0
    var right = sortedList.count - 1 
    
    while left <= right {
        let mid = (left + right) / 2
        
        // 같으면 
        if target == sortedList[mid] {
            return mid
        }
        
        // 다르면 
        if target < sortedList[mid] {
            right = mid - 1
        } else {
            left = mid + 1
        }
        
    }
    
    return -1
}
```


응용하여, 타겟이 위치 가능한 index를 찾는 경우, 중복이 있는경우는 ??  


```swift
// 중복값이 있는 경우 가장 왼쪽 값을 반환함. 타겟을 찾지 못한경우 insert 가능한 index를 반환.
func binarySearch(target: Int, sortedList: [Int]) -> Int {
    
    var left = 0
    var right = sortedList.count
    
    while left < right {
        var mid = (left + right) / 2
        
        if target <= sortedList[mid] {
            right = mid
        } else {
            left = mid + 1
        }
        
    }

    return left
}
```
