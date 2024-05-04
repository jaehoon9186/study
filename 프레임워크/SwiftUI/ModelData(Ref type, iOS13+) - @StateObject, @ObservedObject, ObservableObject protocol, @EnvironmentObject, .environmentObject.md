# ModelData(Ref type, iOS13+) - @StateObject, @ObservedObject, ObservableObject protocol, @EnvironmentObject, .environmentObject

### 참고
- [docs / Monitoring data changes in your app](https://developer.apple.com/documentation/swiftui/monitoring-model-data-changes-in-your-app)
- [https://www.youtube.com/watch?v=J6afKuHJFCE&t=2s](https://www.youtube.com/watch?v=J6afKuHJFCE&t=2s)
- [https://www.youtube.com/watch?v=Pe7RMWrQlZw&t=1198s](https://www.youtube.com/watch?v=Pe7RMWrQlZw&t=1198s)



# 서두

@State, @Binding과 같이 SwiftUI에서 제공하는 객체의 상태를 관찰하는 방법중 하나임.  
***value type***에서는 @State, @Binding property wrapper를 사용해 생성, 바인딩 했다면,  

***reference type***에서는  @StateObject, @ObservedObject, ObservableObject protocol 을 사용함. 

iOS17+ 에서는 Observation 프레임워크에 @Observable macro를 사용하여 좀더 간단하게 구연이 가능함. 

# 사용

1. class 타입 정의 / ObservableObject 프로토콜 채택
- [docs / ObservableObject](https://developer.apple.com/documentation/combine/observableobject#overview)  

```swift
class User: ObservableObject {
    let name: String
    @Published var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
```

combine의 @Published attribute를 사용해 쉽게 추척가능하게 함. 


또한, objectWillChange publisher 를 제공하여 @Published 를 정의하지 않고 커스텀해야할 일이 있다면 이를 사용하변됨. 
이하 참고,  
[https://www.hackingwithswift.com/quick-start/swiftui/how-to-send-state-updates-manually-using-objectwillchange](https://www.hackingwithswift.com/quick-start/swiftui/how-to-send-state-updates-manually-using-objectwillchange)  

</br>
</br>

2. 인스턴스 생성, 주입 / @StateObject
- [StateObject](https://developer.apple.com/documentation/swiftui/stateobject)  


```swift
struct ObservableObjectView: View {
    @StateObject var user = User(name: "홍길동", age: 78) // 생성

    var body: some View {
        ChildView(user: user) // 주입 
    }
}
```

</br>
</br>


3. 전달받기 / @ObservedObject
- [ObservedObject](https://developer.apple.com/documentation/swiftui/observedobject)


@State와 마찬가지고 그냥 인스턴스를 전달하게 된다면 변경이 불가함. 
bindable 인스턴스를 전달해야하는데 이를 위해선 멤버 변수 위치에 @ObservedObject property wrapper를 사용해 전달받을 수 있도록함. (@Binding 처럼)

```swift
struct ChildView: View {

    @ObservedObject var user: User

    var body: some View {
        // contents
    }
}
```

</br>
</br>

4. 맴버변수 바인딩

@Published로 선언된 class 내부의 멤버변수를 바인딩 하려면 ```$```키워드 사용.   
```$user.age```

</br>
</br>


# @EnvironmentObject, .environmentObject

- [docs / Monitoring data changes in your app](https://developer.apple.com/documentation/swiftui/monitoring-model-data-changes-in-your-app)
