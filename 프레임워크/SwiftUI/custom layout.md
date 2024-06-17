# custom layout

- [https://developer.apple.com/videos/play/wwdc2022/10056/](https://developer.apple.com/videos/play/wwdc2022/10056/)
- [https://developer.apple.com/documentation/swiftui/layout](https://developer.apple.com/documentation/swiftui/layout)
- [https://swiftui-lab.com/layout-protocol-part-1/](https://swiftui-lab.com/layout-protocol-part-1/)
- [https://www.youtube.com/watch?v=WD7ebJZ7PaI](https://www.youtube.com/watch?v=WD7ebJZ7PaI)


# layout 프로토콜을 사용한 컨테이너들과 미리 구성된 컨테이너들은 어떤 차이가 있나?

VStack, HStack이 있듯이, iOS16+ 부터 layout 프로토콜을 체택한 VStackLaout 등이 제공됨.  
(AnyLayout, 
GridLayout, 
HStackLayout, 
VStackLayout, 
ZStackLayout)  

어떤 차이가 있지?
하단 Question에 추가 정리. 

animatable protocol 을 준수하기때문에 애니메이션을 적용할 수 있음. 

lazy container로는 구성할 수 없다.  
lazy 컨테이너들은 스크롤에 영향, layout 프로토콜로 구현된 컨테이너들은 한번에. 

layout protocol을 채택하는 [AnyLayout](https://developer.apple.com/documentation/swiftui/anylayout) 타입으로 type-erased 하여 다양한 레이아웃으로 변경하기 용이함.  
(@Environment 등 이용하여 변경하는 등 다양한 방법에 응용 가능, 간단한 예로 가로, 세로 전환시 다른 뷰레이아웃을 제공할 수 있음.) 

# parent View, child view 들이 사이즈를 결정하는 방법은?

# 하나씩 알아보자
# 메서드
### sizeThatFits(proposal:subviews:cache:) 

### placeSubviews(in:proposal:subviews:cache:) 

# 파라미터 
### proposal

### subviews



# Q. 어떻게 뷰들을 전달해, 일반 view 컨테이너 처럼 쓸 수 있는걸까?
- [SE-0253 / https://github.com/swiftlang/swift-evolution/blob/main/proposals/0253-callable.md](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0253-callable.md)
- [https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)

```swift
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Layout {

    /// Combines the specified views into a single composite view using
    /// the layout algorithms of the custom layout container.
    ///
    /// Don't call this method directly. SwiftUI calls it when you
    /// instantiate a custom layout that conforms to the ``Layout``
    /// protocol:
    ///
    ///     BasicVStack { // Implicitly calls callAsFunction.
    ///         Text("A View")
    ///         Text("Another View")
    ///     }
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameter content: A ``ViewBuilder`` that contains the views to
    ///   lay out.
    ///
    /// - Returns: A composite view that combines all the input views.
    public func callAsFunction<V>(@ViewBuilder _ content: () -> V) -> some View where V : View

}
```

기존에 view container들은 @ViewBuilder를 이용해 view 들을 전달 받음.   
layout 프로토콜로 구현한 컨테이너 들은 init에 @ViewBuilder가 없음. 

어떻게 view들을 전달 받는거야?  
이니셜라이저에도 따로 없고, 구현할때는 기존 컨테이너들 처럼 전달 받는데? 어케 가능한건지  

swift 문서 Methods with Special Names 부분에 보면 알 수 있음.  

protocol 기본구현된 메서드 중 callAsFunction 메서드는 Special name으로 정해 놓아서.  

생략이 가능한 거임.  

```swift
// 원래 이건데
CustomHStack(spacing: 10).callAsFunction({ /* View Conponents */ })

// 이렇게 생략 가능해, 기존에 익숙한 컨테이너들 처럼 사용 가능한 것. 
CustomHStack(spacing: 10) {
    /* View Conponents */ 
}
```





