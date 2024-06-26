# Animation - Animatable protocol, VectorArithmetic protocol

### 참고
- [apple docs / Animatable](https://developer.apple.com/documentation/swiftui/animatable)
- [https://swiftui-lab.com/swiftui-animations-part1/](https://swiftui-lab.com/swiftui-animations-part1/)
- [https://www.youtube.com/watch?v=27ZvPQMYS6E&t=348s](https://www.youtube.com/watch?v=27ZvPQMYS6E&t=348s)
- [https://youtu.be/YSBXJvANWSo](https://youtu.be/YSBXJvANWSo)
- [https://swiftwithmajid.com/2020/06/17/the-magic-of-animatable-values-in-swiftui/](https://swiftwithmajid.com/2020/06/17/the-magic-of-animatable-values-in-swiftui/)
- [백터이해 유튜브](https://www.youtube.com/watch?v=fNk_zzaMoSs)
- [https://nerdyak.tech/development/2020/01/12/animating-complex-shapes-in-swiftui.html](https://nerdyak.tech/development/2020/01/12/animating-complex-shapes-in-swiftui.html)

# 
[AnimatableModifier](https://developer.apple.com/documentation/swiftui/animatablemodifier) 는 삭제. (~ iOS 17.5)

Animatable 프로토콜만 알아봄.  

# 

Animatable 프로토콜을 채택한 뷰를 애니메이션이 동작할 대상으로 결정함. 

문서에 보면 어떤 오브젝트가 채택했는지 써있음.   

  

AnimatableData 타입은 VectorArithmetic 프로토콜을 준수하는 타입.  

벡터산술연산에 필요한 프로퍼티 메서드를 제공. 객체의 상태를 변화시키는데 사용?  





```swift
/// A type that describes how to animate a property of a view.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol Animatable {

    /// The type defining the data to animate.
    associatedtype AnimatableData : VectorArithmetic

    /// The data to animate.
    var animatableData: Self.AnimatableData { get set }
}
```

VectorArithmetic? 수학시간에 배웠던.. 벡터를 바탕으로 동작. 곱, 합 등을 하며  
```swift
/// A type that can serve as the animatable data of an animatable type.
///
/// `VectorArithmetic` extends the `AdditiveArithmetic` protocol with scalar
/// multiplication and a way to query the vector magnitude of the value. Use
/// this type as the `animatableData` associated type of a type that conforms to
/// the ``Animatable`` protocol.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol VectorArithmetic : AdditiveArithmetic {

    /// Multiplies each component of this value by the given value.
    mutating func scale(by rhs: Double)

    /// Returns the dot-product of this vector arithmetic instance with itself.
    var magnitudeSquared: Double { get }
}
```


<p align="center">
  <img height="200" src="https://github.com/jaehoon9186/study/assets/83233720/f684f007-99a1-4d7d-b1f1-47659e6449a2">
</p>


1,2,4차원의 벡터를 가질 수 있음.   
CGFloat, Double == 1차원 벡터  
CGPoint, CGSize == 2차원 벡터  
CGRect == 4차원 벡터  


2개, 3개 이상의 백터로, animatableData를 갖는다면  
AnimatablePair, EdgeInsets 를 사용하는 방법이 있음.  

```AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>>``` 요론식으로 쓸 순 있겠지만 유연하지 않음. 

이때, VectorArithmetic 프로토콜을 채택해 커스텀한 벡터 타입을 구현해보자. 





애니메이션 동작 중 스유는 view를 계속 regenerating하며 그때마다 animating parameter를 계속 수정함.   

주의, 커스텀 Animatable은 모든 프레임에 대해 바디를 실행해 내장 effect보다 더 많은 리소스가 사용될 수 있다함.  
(내장만으로 불가 할때 구현할 것을 권장한다함. )  



아래 예와 같이 custom shape에도 적용이 가능, custom view도 가능.  


# i.g. custom shape 

```swift
struct Trapezoid: Shape {
    var insetAmount: Double

    // MARK: *
    var animatableData: Double {
        get { return insetAmount }
        set { insetAmount = newValue}
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
}

struct ContentView: View {
    @State private var insetAmount = 50.0


    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
    }
}
```

<p align="center">
  <img height="250" src="https://github.com/jaehoon9186/study/assets/83233720/b5459a86-5156-45d5-9cd8-5937d7242702">
</p>




