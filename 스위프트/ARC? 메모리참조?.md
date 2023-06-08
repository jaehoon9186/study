# ARC? 메모리 참조?
[도큐먼트](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)

## 


> CODE
```swift
class Person {
    let name: String
    var friend: Person?

    init(name: String) {
        self.name = name
        print("\(name) 생성")
    }
    deinit {
        print("\(self.name) 메모리에서 해제!")
    }

}

var chul: Person?
var young: Person?

chul = Person(name: "김철수")  // Person(name: "김철수") : reference count = 1
young = Person(name: "김영희") // Person(name: "김영희") : reference count = 1

chul = nil   // Person(name: "김철수") : reference count = 0
young = nil  // Person(name: "김영희") : reference count = 0
```

rc가 0으로 되며 두개의 person 인스턴스가 deinit되어 메모리에서 해제된다. 
<br>

```swift
chul = Person(name: "김철수")  // Person(name: "김철수") : reference count = 1
young = Person(name: "김영희") // Person(name: "김영희") : reference count = 1

chul?.friend = young // Person(name: "김영희") : reference count = 2
young?.friend = chul // Person(name: "김철수") : reference count = 2

chul = nil   // Person(name: "김철수") : reference count = 1
young = nil  // Person(name: "김영희") : reference count = 1
```
chul 인스턴스, young 인스턴스의 friend변수에 서로를 추가해 보았다.  
rc는 참조를 한번 더 하기에 1씩 늘어나고, nil로 rc값을 -1하여도 최종적으로 1이기 때문에 메모리에는 계속 남아있는 상황이 된다.

강한참조 사이클 이라고하며, 이런경우 메모리 누수(memory leak)가 발생한다. 



참조에는 3가지 참조가 있다. 
* Strong Reference
  : rc를 1증가시김. 강한참조사이클(Strong Reference Cycle)을 발생시킬 수 있다. 직접 해제 해줘야함. 
* Weak Reference
  : rc를 증가시키지 않음. 강한 참조를 유지하지 않는다. 자신이 가리키고 있는 인스턴스가 메모리에서 해제되면 자동으로 ARC에서 nil할당. 
* Unowned Reference
  : Weak 참조 와의 차이점은 nil 불가 항상 값이 있어야함(옵셔널 불가). 단, nil이 할당되는 경우 발생시 앱이 중단될수 있는 위험이 있다. 
  왜있는거임? 1. 가독성, 항상값이 있다는 것을 표기한다. 2. 퍼포먼스, nil처리를 하지 않아도 되기에 그만큼 더 빠르다.
  
  
```swift
class Person {
    let name: String
    weak var friend: Person?

    init(name: String) {
        self.name = name
        print("\(name) 생성")
    }

    deinit {
        print("\(self.name) 메모리에서 해제!")
    }

}
```
weak 키워드로 메모리 누수 예방. 



## 어떻게 누수 나는지 확인함?
xcode -> Product -> Profile -> Leak -> 녹화 -> 앱 동작 -> leak 확인

<img width="836" alt="스크린샷 2023-06-08 오후 5 33 49" src="https://github.com/jaehoon9186/study/assets/83233720/9e2f3e47-d9df-460a-971f-96a45215c043">
<img width="1396" alt="스크린샷 2023-06-08 오후 5 31 07" src="https://github.com/jaehoon9186/study/assets/83233720/5ac26aef-c717-48bd-afca-ae5817c2c6c9">


