# Animation - Custom, CustomAnimation protocol

- [https://developer.apple.com/documentation/swiftui/customanimation](https://developer.apple.com/documentation/swiftui/customanimation)
- [https://swiftui-lab.com/swiftui-animations-part6/](https://swiftui-lab.com/swiftui-animations-part6/)
- [https://www.youtube.com/watch?v=IuSuHJs5-KE&t=1024s](https://www.youtube.com/watch?v=IuSuHJs5-KE&t=1024s)

# 커스텀 애니메이션 사용

// apple docs에 있는 예제 ElasticEaseInEaseOutAnimation 커스텀 애니메이션  

```swift
withAnimation(Animation(ElasticEaseInEaseOutAnimation(duration: 0.4))) { }
```

이런식으로 할 수 있지만. 


```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Animation {
    public static func linear(duration: TimeInterval) -> Animation
    public static var linear: Animation { get }
}
```

built-in animation들이 요론식으로 구현되어 있는것 처럼. 

커스텀 애니메이션을 만들어 extension으로 쉽게 사용할수있도록 단순화 할 수 있다. 

```swift
extension Animation {
    static var elasticEaseInEaseOut: Animation { elasticEaseInEaseOut(duration: 0.35) }
    static func elasticEaseInEaseOut(duration: TimeInterval) -> Animation {
        Animation(ElasticEaseInEaseOutAnimation(duration: duration))
    }
}
```

```swift
withAnimation(.elasticEaseInEaseOut) { }
```

(컴파일러가 아규먼트로 Animation 타입임을 이미 알아서 바로접근가능함. )

# 커스텀 애니메이션 정의 

### CustomAnimation protocol
CustomAnimation protocol 에 대해 먼저 

```swift
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public protocol CustomAnimation : Hashable {
    func animate<V>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? where V : VectorArithmetic

    func velocity<V>(value: V, time: TimeInterval, context: AnimationContext<V>) -> V? where V : VectorArithmetic

    func shouldMerge<V>(previous: Animation, value: V, time: TimeInterval, context: inout AnimationContext<V>) -> Bool where V : VectorArithmetic
}
```

CustomAnimation 프로토콜을 채택함으로서 커스텀애니메이션을 정의 할 수 있는데.  

프로토콜을 채택하면 3가지 메서드를 구현해야함. animate는 필수고, velocity, shuldMerge는 프로토콜 기본구현으로 구현되어 있어 옵셔널임.   

각 메서드에 대한 설명에 앞서, 매개변수(파라미터)를 먼저 보도록하자. 

* value: 애니메이션을 적용할 벡터 value, VectorArithmetic을 따름. 
* time: 애니메이션 동작 시간
* context: AnimationContext의 인스턴스, 이를 통해 state, environment에 접근가능. 




### AnimationContext


