# enum 열거형 모든케이스

- [https://developer.apple.com/documentation/swift/caseiterable](https://developer.apple.com/documentation/swift/caseiterable)

```swift
enum AudioDynamic {
    case none       
    case normal     
    case strong     

    static let allCases: [AudioDynamic] = [.none, .normal, .strong]

    func next() -> AudioDynamic {
        let currentIndex = AudioDynamic.allCases.firstIndex(of: self)!
        let totalCasesCount = AudioDynamic.allCases.count

        return AudioDynamic.allCases[(currentIndex + 1) % totalCasesCount]
    }
}
```

(옵셔널 바인딩안함. )  

allCases 상수는 케이스가 추가될때 같이 수정해줘야함.   


이렇게 하려고 했는데  


CaseIterable 프로토콜을 채택하면 쉽게 열거형의 모든 케이스를 배열로 접근가능하다.  

```swift
enum AudioDynamic: CaseIterable {
    case none       
    case normal     
    case strong     

    func next() -> AudioDynamic {
        let allCases = Self.allCases
        guard let currentIndex = allCases.firstIndex(of: self) else {
            return self
        }
        return allCases[(currentIndex + 1) % allCases.count]
    }
}

```

---
+  

```swift
enum AudioDynamic: CaseIterable {
    case none       
    case normal     
    case strong     

    static let allCasesList: [Self] = Self.allCases

    func next() -> Self {
        guard let currentIndex = Self.allCasesList.firstIndex(of: self) else {
            return self
        }

        return Self.allCasesList[(currentIndex + 1) % Self.allCasesList.count]
    }
}

```

잦은 호출이 이루어진다면 이렇게 해볼까?  
성능적으로 어떤 이점이 있을지  

static은 Data 영역에 저장되는데 / stack보다는 속도가 떨어지지 않나  

vs  

next 메서드는 자주 수행하게 될건데  
미리 로드해 놓는것이 나을 수도 있을것?  

