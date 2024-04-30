# Model data(view state) - @State, @Binding

- [article docs / Managing user interface state](https://developer.apple.com/documentation/swiftui/managing-user-interface-state)
- [youtube / SwiftUI tutorial for Beginners - @State vs @Binding - How to pass data between views?](https://www.youtube.com/watch?v=q8nBhtmuKXs)

# @State

```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen @propertyWrapper public struct State<Value> : DynamicProperty {
    public init(wrappedValue value: Value)

    public init(initialValue value: Value)

    public var wrappedValue: Value { get nonmutating set }

    public var projectedValue: Binding<Value> { get }
}
```

@State Attribute는 SwiftUI 프레임웤에서 구현해 놓은 property wrapper입니다.   
> property wrapper? 반복되는 로직이나 동작을 캡슐화함. 가독성을 높이고 유지보수를 용이하게함.   
property wrapper애 대한 자세한 내용은 아래링크를 참고바랍니다.   
[링크 swift문서](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Wrappers)  


SwiftUI에서는 @State 라는 캡슐화된 propertyWrapper를 사용해 뷰를 재사용성 있게 함. 

didset과 같은 느낌인데 왜? @State라는 propertyWrapper를 만들었을까?

swiftUI의 View는 struct임. member property를 변경하려면 mutating 키워드를 사용해야함. 

값이 변경되면 어떻게 뷰를 rerender할까?




# @Binding

<p align="center">
  <img width="589" alt="스크린샷 2024-04-30 오후 10 28 21" src="https://github.com/jaehoon9186/study/assets/83233720/c641f7e1-eff2-4adb-b234-0d222e352c1b">
</p>

위의 이미지 


# 구현

<p align="center">
  <img width= "200" src="https://github.com/jaehoon9186/study/assets/83233720/106da572-27f7-42cb-b68b-567f051b0d62">
</p>

```swift
struct FirstView: View {
    @State private var isRed: Bool = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack {
                    Rectangle()
                        .fill(isRed ? .red : .orange)
                        .frame(width: 200, height: 50)
                        .onTapGesture {
                            isRed.toggle()
                        }
                }

                NavigationLink {
                    SecondView(isRed: $isRed)
                } label: {
                    Text("next View")
                }

            }
        }
    }
}

struct SecondView: View {
    @Binding var isRed: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(isRed ? .red : .orange)
                .onTapGesture {
                    isRed.toggle()
                }
        }

    }
}
```
