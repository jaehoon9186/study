# ModelData(Ref type, iOS17+) - @Observable, @State, @Bindable, @Environment

### 참고
- [docs / Observation Framework](https://developer.apple.com/documentation/observation)
- [docs / Bindable](https://developer.apple.com/documentation/swiftui/bindable)
- [docs samplecode / Migrating from the Observable Object protocol to the Observable macro](https://developer.apple.com/documentation/swiftui/migrating-from-the-observable-object-protocol-to-the-observable-macro)
- [https://www.youtube.com/watch?v=EuAGDhJpUN0](https://www.youtube.com/watch?v=EuAGDhJpUN0)
- [https://www.youtube.com/watch?v=Pe7RMWrQlZw&t=1198s](https://www.youtube.com/watch?v=Pe7RMWrQlZw&t=1198s)
- [wwdc23 / Discover Observation in SwiftUI](https://developer.apple.com/videos/play/wwdc2023/10149/)


# iOS 17이후 ref type binding

이전에는 
@ObservableObject, @Published 로 정의  
@StateObject 로 생성   
@ObservedObject 로 전달받음.  


iOS 17버전부턴  ***macro @Observable***    
@Observable, @State, @Bindable로 구현.  

Observation Framework([docs 링크](https://developer.apple.com/documentation/observation))에 구현되어 있음.  


</br>
</br>
</br>


<p align="center">
  <img width="552" alt="스크린샷 2024-05-06 오후 3 43 30" src="https://github.com/jaehoon9186/study/assets/83233720/0d882f4a-a473-4d0b-8066-2b0314ba3de8">
</p>

@Observaion 에 우클릭으로 확장을 하면 어떤식으로 구성되는지 볼 수 있음,   

</br>
</br>
</br>

<p align="center">
  <img width="1008" alt="스크린샷 2024-05-06 오후 3 46 20" src="https://github.com/jaehoon9186/study/assets/83233720/aeae7214-31e7-437d-8bec-cea561150c53">
</p>

...   
다시 닫아보자..  


# how to use

0. 
```swift
import Observation
```
(이거 꼭 import 안해도 되던데.. swiftUI에 포함인지.. )

</br>
</br>

1. class 정의 / @Observable macro
```swift
@Observable
class User {
    let name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
```

</br>
</br>


2. class 인스턴스 생성, 주입 / @State
```swift
struct First: View {

    @State var user = User(name: "홍길동", age: 78)

    var body: some View {
        // contents
        Second(user: user)
    }
}
```

</br>
</br>



3. 바인딩 / @Bindable

```swift
struct Second: View {
    @Bindable var user: User

    var body: some View {
        // contents
    }
}
```

</br>
</br>

# +ɑ @Environment, .environment() 

ios17이전은 
@@EnvironmentObject 인스턴스 생성,   
이후는  
@Environment(class meta type)으로 environment object 생성.  

</br>
</br>

.environment() 모디파이어로 외부에서 주입  
주입된 뷰 이하에서는 @Environment() property wrapper로 접근가능함.   


</br>
</br>

```swift
FirstView()
  .environment(AppState()) // @Observable class AppState {} 정의 
```

</br>
</br>

```swift
struct FirstView: View {

    @Environment(AppState.self) private var appState

    var body: some View {
        // contents

        SecondView() // SecondView 에서도 @Environment(AppState.self) property wrapper로 접근가능. 
    }
}

```

</br>
</br>

### environment의 맴버변수를 바인딩할때 에러가 발생한다면.

<p align="center">
  <img width="679" alt="스크린샷 2024-05-06 오후 7 51 44" src="https://github.com/jaehoon9186/study/assets/83233720/dfa03285-82a2-488a-9dc4-9a4e13536959">
</p>

```swift
struct FirstView: View {

    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var appState = appState // in Body에 @Bindable property wrapper로 재할당. 

        // Contents
    }
}
```
