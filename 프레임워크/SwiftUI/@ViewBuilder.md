# @ViewBuilder

- [https://developer.apple.com/documentation/swiftui/viewbuilder](https://developer.apple.com/documentation/swiftui/viewbuilder)
- [https://www.youtube.com/watch?v=pXmBRK1BjLw](https://www.youtube.com/watch?v=pXmBRK1BjLw)


# 

<img width="377" alt="스크린샷 2024-06-11 오후 5 59 12" src="https://github.com/jaehoon9186/study/assets/83233720/f96287bf-0980-48ca-9190-0d3e54108e44">

요런 해더뷰를 다양한 뷰에서 사용하는 경우. 

view struct를 새로 정의해 재사용성을 높일 수 있음.  

title, subtitle 을 멤버 변수로 지정해 init 할 수 있음. 

그러나, 옵셔널이기에 필요하지 않은 경우도 있어 옵셔널바인딩으로 view를 구분해 주거나,  
subtitle이 한가지 하나의 타입만 전달 받는 제약이 있음.  

# 1. 
제너릭과 @ViewBuilder를 활용해 이를 해결할 수 있음.   
바로 생성할때 아규먼트를 전달받을때 view를 전달 받는 거임.   

```swift
// 제너릭만. 
struct HeaderView<Content:View>: View {
    let title: String
    let content: Content

    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}
```

만약 옵셔널로 subtitle인 content 변수를 받는다 싶으면 옵셔널을 붙혀주면 되겠지만 그렇게 된다면 body 분에 또 번거롭게 옵셔널 바인딩 해줘야함. 전달할때도 nil을 전달해줘야함. init때 구분할 수도 있고.  


제너릭과 viewbuilder까지 사용해 조금더 가독성이 좋아지고, 유연하게 만들 수도 있음. 

클로저로 전달하기에 init할때 간결하게 넣을 수 있음.

```swift
struct HeaderView<Content:View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}
```


# 2. 

다양한 타입을 하나로 묶는 용도로도 사용 가능함.  

HStack, VStack과 같은 컨테이너도 비슷한 로직.  

```swift
enum ViewType {
    case one, two, three
}

struct ContentView: View {

    let type: ViewType

    var body: some View {
        headerView
    }
  
    private var headerView: some View {  // ERROR: 
        switch type {
        case .one:
            Circle()
        case .two:
            Text("2")
        case .three:
            VStack {
                Text("3")
            }
        }
    }
}
```

이런 경우 switch-case에 따라 반환되는 타입이 달라 에러가 발생함. 

switch-case를 컨테이너로 묶어 하나의 타입으로 만들어 반환하면 해결되긴함. (아래는 VStack, @ViewBuilder 사용됨)
```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct VStack<Content> : View where Content : View {
    @inlinable public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content)
    public typealias Body = Never
}
```

메서드에 @ViewBuilder를 사용해 해결 가능. 

```swift
@ViewBuilder private var headerView: some View {
    switch type {
    case .one:
        Circle()
    case .two:
        Text("2")
    case .three:
        VStack {
            Text("3")
        }
    }
}
```
