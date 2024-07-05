# custom layout

- [https://developer.apple.com/videos/play/wwdc2022/10056/](https://developer.apple.com/videos/play/wwdc2022/10056/)
- [https://developer.apple.com/documentation/swiftui/layout](https://developer.apple.com/documentation/swiftui/layout)
- [https://swiftui-lab.com/layout-protocol-part-1/](https://swiftui-lab.com/layout-protocol-part-1/)
- [https://www.youtube.com/watch?v=WD7ebJZ7PaI](https://www.youtube.com/watch?v=WD7ebJZ7PaI)
- [https://medium.com/@valentinjahanmanesh/swiftui-layout-protocol-ios-16-0-4d3420d8d6c4](https://medium.com/@valentinjahanmanesh/swiftui-layout-protocol-ios-16-0-4d3420d8d6c4)
- [https://medium.com/the-swift-cooperative/mastering-viewthatfits-3294d74cb17b](https://medium.com/the-swift-cooperative/mastering-viewthatfits-3294d74cb17b)

# layout 프로토콜을 사용한 컨테이너들과 미리 구성된 컨테이너들은 어떤 차이가 있나?

VStack, HStack이 있듯이, iOS16+ 부터 layout 프로토콜을 체택한 VStackLaout 등이 제공됨.  
(AnyLayout, 
GridLayout, 
HStackLayout, 
VStackLayout, 
ZStackLayout)  

어떤 차이가 있지?

animatable protocol 을 준수하기때문에 애니메이션을 적용할 수 있음. 

lazy container로는 구성할 수 없다.  
lazy 컨테이너들은 스크롤에 영향, layout 프로토콜로 구현된 컨테이너들은 한번에 로드. 

layout protocol을 채택하는 [AnyLayout](https://developer.apple.com/documentation/swiftui/anylayout) 타입으로 type-erased 하여 다양한 레이아웃으로 변경하기 용이함.  
(@Environment 등 이용하여 변경하는 등 다양한 방법에 응용 가능, 간단한 예로 가로, 세로 전환시 다른 뷰레이아웃을 제공할 수 있음.)   

익숙한 컨테이너 처럼 사용가능한데 어떻게 가능한거지? 하단 Question에 추가 정리. 

# parent View, child view 들이 사이즈를 결정하는 방법은?
스유의 기존 view 메커니즘과 동일. 
자식에게 사이즈 제안하고, 자식은 제안을 바탕으로 사이즈 정하고 부모로 전달, 부모는 alignment.  

이때 사용 되는 메서드가 sizeThatFits, placeSubviews임.  



# 하나씩 알아보자
* sizeThatFits(proposal:subviews:cache:) 
* placeSubviews(in:proposal:subviews:cache:)

두개의 메서드를 구현해야함. 두개는 필수  
먼저 각 메서드에 필요한 파리미터들을 알아봄.  


# 파라미터 
### - proposal: ProposedViewSize

자식뷰들을 측정하고 위치시킬때 사용. 

부모뷰가 자식들에게 어떻게 니들 사이즈 결정할 건지를 제안함.  
(45.0 이면 부모뷰가 자식뷰의 사이즈를 45로 제안한다는.)  
CGFloats 페어로 구성(width, height)  

* 정확한 수치를 제안한 경우

0.0, nil, .inifnity 로 설정할 경우 특별한 proposal로 사용됨.  
* 0.0: child view responds with its minimum size
* .infinity: child view responds with its maximum size.
* nil (unspecified): child view responds with its ideal size.


이해하기론 부모뷰에 frame() 모디파이어로 크기를 제한할때 proposal로 전달되는 듯 싶음.   
(+ custom layout을 정의해 디버깅해봄 ㅇㅇ )  

```swift
VStackLayout {
        Circle()
            .frame(width: 50, height: 50)
        Circle()
            .frame(width: 100, height: 100)
        Circle()
        Circle()
            .frame(width: 10, height: 10)
    }
    .border(.black)
//  .frame(width: 200.0, height: 200.0) // 특정 크기 제안
//  .frame(width: 0.0, height: 0.0) // 0.0
//  .frame(width: nil, height: nil) // Nil, .frame 모디파이어를 사용하지 않는것과 같음.
//  .frame(width: .infinity, height: .infinity) // .infinity
```
[https://fatbobman.com/en/posts/layout-dimensions-1/](https://fatbobman.com/en/posts/layout-dimensions-1/)

```
minimum     <     ideal      <     maximum 
  0.0              nil             
 .zero           .unspecified     .infinity
```




### - subviews: Self.Subviews

[https://developer.apple.com/documentation/swiftui/layoutsubview](https://developer.apple.com/documentation/swiftui/layoutsubview)

a collection of LayoutSubview elements 

proxy(대리자)로서 뷰의 정보를 얻거나 뷰를 위치시키거나 하는 용도로 사용.  
메서드, get property를 사용하여(문서참고)   

<p align="center">
    <img width="1080" alt="스크린샷 2024-06-19 오후 2 39 51" src="https://github.com/jaehoon9186/study/assets/83233720/874b9cdc-d6e1-486c-85b7-6bdfb33baf02">
</p>

자식뷰 ㅇㅇ, 손자뷰까진 ㄴㄴ   


.sizeThatFits() 로 해당 자식뷰에게 뷰사이즈를 제안할 해여 자식뷰의 사이즈를 반환받을 수 있음.  
subviews[0].sizeThatFits(.unspecified) 이런식으로  
sizeThatFits(ProposedViewSize(width: 0.0, height: .infinity)) 이런식으로 width, height에 각각 다른 속성으로 제안할 수도 있음.  


dimensions(in:) 인스턴스 메서드도 있는데 이건 치수에 추가적으로 alignment guide까지? 요청하는 것같음. 


 
### - in bounds: CGRect

placeSubviews메서드의 파라미터   

CGRect 타입이라 원점과 사이즈로 구성.  

size는 sizeThatFits메서드에 의해 반환되는 CGSize와 같음.   

원점(.origin)은 해당 커스텀뷰의 위치를 가리키는 것 같음.   




# 메서드
### sizeThatFits(proposal:subviews:cache:) 

하위뷰들의 프록시(subviews)들을 바탕으로 커스텀레이아웃의 사이즈를 결정함.  

세가지 전달받음. proposal:subviews:cache:   

여러번 호출 됨. 다른 proposals 과 함께 , 콘테이너의 유연성을 테스트하기 위해?

proposal은 조합 될 수 있음. 예를 들어 width 0.0, height: .infinity 




### placeSubviews(in:proposal:subviews:cache:) 
- [placeSubviews(in:proposal:subviews:cache:)](https://developer.apple.com/documentation/swiftui/layout/placesubviews(in:proposal:subviews:cache:))

커스텀 레이아웃에 subviews들을 위치를 할당.  

명시적으로 제시하지 않은경우 child view들은 중앙에 위치  

<p align="center">
    <img width="542" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/a26086cd-2f61-41fa-a415-eb0ab2efc639">
</p>

바운드, spacing, view proxy 등을 계산해 구현하고자 하는 레이아웃에 맞춰 위치에 배치


### 추가 정의가 필요하다면? 

* explicitAlignment(of:in:proposal:subviews:cache:)  
    
    커스텀레이아웃의 부모컨테이너에서 alignment를 정의 했을 경우 각 조건에 맞춰 해당 커스텀 레이아웃의 위치를 지정할 수 있음. 
  
* spacing(subviews:cache:)

    커스텀 레이아웃 바깥의 spacing을.. 내부 childView 끼리의 spacing 아님. 

* layoutProperties

    일단, 속성이 stackOrientation 이거 하나뿐임. spacer가 어느방향으로 확장될껀지 

* makeCache(subviews:)

    차차

* child view 우선순위

    child views 의 모디파이어를 통해 우선순위를 정한다면, 프록시의 .priority 프로퍼티를 바탕으로 사용자 정의 가능.

* child view 간에 spacing을 설정하려면?  

    멤버 프로퍼티를 정의하고 이를 활용해 sizeThatFits, placeSubviews 의 계산에 활용하지. 



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

layout 프로토콜로 구현한 컨테이너 들은 init에 @ViewBuilder가 없음. 

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





