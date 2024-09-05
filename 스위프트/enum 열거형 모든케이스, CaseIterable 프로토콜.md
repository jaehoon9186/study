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



