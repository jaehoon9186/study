# UI에서의 변화를 원하지 않아 @ObservationIgnored

- [https://developer.apple.com/documentation/swiftui/migrating-from-the-observable-object-protocol-to-the-observable-macro](https://developer.apple.com/documentation/swiftui/migrating-from-the-observable-object-protocol-to-the-observable-macro)
- [https://developer.apple.com/documentation/Observation/ObservationIgnored()](https://developer.apple.com/documentation/Observation/ObservationIgnored())


iOS 17 이상부터는 @Observable 메크로를 사용해 맴버변수를 관찰가능하게 됨 (@Published 사용안해도)  

그냥 내부로직을 수행하기위한 변수는 UI업데이트에 사용하질 않잖슴.  

그때는 

```swift
class ViewModel {
    @ObservationIgnored var onlyInsideLogic = 0
}
```

@ObservationIgnored 메크로를 사용해 제와 시켜주면 된다.
