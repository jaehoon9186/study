# @Observable macro 멤버변수를 바인딩하기 
- [https://stackoverflow.com/questions/77081347/how-to-get-a-publisher-from-a-value-since-the-beauty-of-observable](https://stackoverflow.com/questions/77081347/how-to-get-a-publisher-from-a-value-since-the-beauty-of-observable)

스택 오버플로우의 예제를 참고해 작성함. 

```swift
@Observable class Foo1 {

  var isEnabled = false

  init() {
    isEnabled
      .map { $0 } // Error: Value of type 'Bool' has no member 'map'
  }
}

class Foo2: ObservableObject {

  @Published var isEnabled = false

  var cancellables = Set<AnyCancellable>()

  init() {
    $isEnabled
      .map { $0 } // Works like a charm
      .sink { print($0.description) }  
      .store(in: &cancellables)
  }
}
```

ObservableObject 프로토콜을 사용한 경우에서는 @Published 변수는 '$'키워드를 사용해 바로 바인딩이 가능했다.  

@Observable 메크로의 경우 바인딩이 불가했는데.  

답변으로는.  

```swift
var isEnabled = false {
    didSet { isEnabled$.send(isEnabled) }
  }
var isEnabled$ = CurrentValueSubject<Bool, Never>(false)
```

```swift
var isEnabled: Bool = false { didSet { isEnabled$ = isEnabled } }
@ObservationIgnored
@Published var isEnabled$: Bool = false
```

subject를 사용하거나, @ObservationIgnored @Published 를 사용하여 바인딩하는듯 하다.    

UI에서도 관찰가능해야하기때문에 기존 변수외에 $를 붙인 새로운 멤버변수를 만들어준듯.   

이런식으로해야하나보다..  


