# inout 키워드, copy-in copy-out
- [https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#In-Out-Parameters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#In-Out-Parameters)

```swift
func someFunction(a: inout Int) {
    a += 1
}
```

```swift
var x = 7
someFunction(&x)
print(x)  // Prints "8"
```
// 앰퍼센트로 변경할 값을 전달하겠다 해야함. 



'값'타입을 메서드를 통해 변경하기 위해서 사용. 

reference 타입처럼 변경하는거 아님.  

1. 아규먼트 복사
2. 메서드에서 복사본을 사용해 메서드 수행. 
3. 원래 아규먼트에 복사본 할당

이런순으로함.  




