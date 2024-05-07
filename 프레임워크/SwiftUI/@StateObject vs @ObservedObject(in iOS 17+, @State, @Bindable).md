# @StateObject vs @ObservedObject(in iOS 17+, @State, @Bindable)

### 참고
- [https://developer.apple.com/documentation/swiftui/monitoring-model-data-changes-in-your-app](https://developer.apple.com/documentation/swiftui/monitoring-model-data-changes-in-your-app)
- [https://www.youtube.com/watch?v=RvzJLekIjRs](https://www.youtube.com/watch?v=RvzJLekIjRs)
- [https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/](https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/)
- [https://medium.com/hcleedev/swift-observedobject%EC%99%80-stateobject-4f851ed9ef0d](https://medium.com/hcleedev/swift-observedobject%EC%99%80-stateobject-4f851ed9ef0d)

# 무슨 차이? 

단순히 @StateObject는 ref type인 object를 관찰하기 위해, @ObservedObject는 관찰가능한 object를 전달받기 위해.  
로 생각했으나.. @ObservedObject로도 object 생성이 가능하다는 것을 알았다.  

<p align="center">
  <img width="1094" alt="스크린샷 2024-05-07 오후 7 33 32" src="https://github.com/jaehoon9186/study/assets/83233720/dfda2594-b52c-4382-82ed-c8a10a6eadb0">
  <img width="1080" alt="스크린샷 2024-05-07 오후 7 33 50" src="https://github.com/jaehoon9186/study/assets/83233720/1ceba731-a294-4aa5-945d-6996cbb5ed24">
</p>

먼저 iOS13에서는 @ObservedObject 만을 사용해 관찰 가능한 오브젝트를 생성하고 전달받고 했는데, @State에 의해 뷰가 re-Rander되면 해당오브젝트도 re-init되는 문제를 찾게됨.  
그래서 iOS14에서 @StateObject를 만들어 조치함.  

<p align="center">
  <img width="807" alt="스크린샷 2024-05-07 오후 8 04 42" src="https://github.com/jaehoon9186/study/assets/83233720/8cd30a9e-b202-4b91-9552-cd0f97cd46f1">
</p>

[문서](https://developer.apple.com/documentation/swiftui/monitoring-model-data-changes-in-your-app)에서 제공되는 내용을 보면, 
@StateObject property wrapper를 통해 생성된 observed obejct는 SwiftUI에 의해 단일객체로 생성, 관리되됨. 따라서 뷰가 재생성되어도 영향이 없도록함. 



### 언제 어떤것을 사용해?
위와 같은 문제를 피하려면 단순히 @State로 생성하고 전달 받을때 @ObservedObject로 받으면 됨.  

단, ViewModel과 같은 observable object가 초기화되길 바란다면 @ObservedObject로 생성할 수도 있음. 의도에 따라 선택할 수 있음.  

문서보면 그냥 @StateObject로 생성, 전달받을땐 @ObservedObject로 전달받도록 한거보니 그렇게 사용하면 될 듯.  



# 예제 

<p align="center">
  <img height="500" alt="스크린샷 2024-04-23 오전 11 36 03" src="https://github.com/jaehoon9186/study/assets/83233720/d0cbc954-241e-4456-b533-a81cb34a89fb">
</p>


```swift
// ViewModel
class CountViewModel: ObservableObject {
    @Published var count = 0

    init() { print("vm init") }

    deinit { print("vm deinit") }

    func increaseCount() {
        count += 1
    }
}
```

```swift
struct RandomView: View {
    @State private var randomNumber = 0
    var body: some View {
        VStack {
            Text("랜덤넘버: \(randomNumber)")
            Button("랜덤") {
                randomNumber = (0...10).randomElement()!
            }

            Divider()

            ChildView()
        }
    }
}

struct ChildView: View {
    @StateObject private var viewModel = CountViewModel()

    var body: some View {
        VStack {
            Text("카운트: \(viewModel.count)")
            Button("카운트 + 1") {
                viewModel.increaseCount()
            }
            .padding(.bottom, 10)
        }
    }
}
```

# iOS 17+ 에서는? (@Observable mecro, @State, @Bindable)

마찬가지로 @Bindable 로 생성된 인스턴스는 뷰가 re-Rander될때 초기화가 됨.  

### problem, 왜 re-init이 되는지 모르겠다. 
@State property wrapper로 인스턴스를 생성해도 계속 init, deinit이 됨. view에 보여지는 값은 변화없이..  
같은 문제를 애플포럼에서도 확인 할 수 있었지만 답변을 찾을 순 없었다.  
[https://forums.developer.apple.com/forums/thread/739760](https://forums.developer.apple.com/forums/thread/739760)
