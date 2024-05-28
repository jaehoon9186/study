# animation

### 참고
- [docs / animation](https://developer.apple.com/documentation/swiftui/animations)
- [https://www.youtube.com/watch?v=86H8t0yNFA8](https://www.youtube.com/watch?v=86H8t0yNFA8)
- [WWDC23: SwiftUI 애니메이션 살펴보기 | Apple](https://www.youtube.com/watch?v=IuSuHJs5-KE)

# 적용

@State 프로퍼티가 변경되면 하위 뷰에 애니메이션 적용  

세가지 방법으로 
1. withAnimation(_:_:) global function
2. animation(_:value:) view modifier
3. animation(_:) binding's method


### 1.  withAnimation(_:_:) 
<p align="center">
  <img height="250" src="https://github.com/jaehoon9186/study/assets/83233720/ad503973-d081-4a79-9aeb-d2fc3a410467">
</p>

```swift
// property
@State var isAnimated = false

// in body
Circle()
    .fill(.purple)
    .frame(width: isAnimated ? 50 : 200)
Circle()
    .fill(.yellow)
    .frame(width: isAnimated ? 50 : 200)

// button
Button("toggle") {
    withAnimation(.spring(duration: 0.3, bounce: 0.7)) {
        isAnimated.toggle()
    }
}
```

withAnimation 메서드 클로저에 해당하는 @State 프로퍼티와 관련된 모든 View compnent들에 애니메이션 적용함. 


### 2. animation(_:value:)

<p align="center">
  <img height="250" src="https://github.com/jaehoon9186/study/assets/83233720/d38033d3-a617-4ecc-ba88-b1943402dd4a">
</p>

```swift
// property
@State var isAnimated = false

// in body
Circle()
    .fill(.purple)
    .frame(width: isAnimated ? 50 : 200)
    .animation(.easeIn, value: isAnimated)
Circle()
    .fill(.yellow)
    .frame(width: isAnimated ? 50 : 200)
    .animation(.bouncy(duration: 0.5, extraBounce: 0.2), value: isAnimated)

// button
Button("toggle") {
    isAnimated.toggle()
}
```

view component에 개별적으로 애니메이션 적용.  

   
+) 특정 컴포넌트에 애니메이션 적용을 원치 않는다면? 아래와 같이 nil 값을. 
```swift
Circle()
      .fill(.yellow)
      .frame(width: isAnimated ? 50 : 200)
      .animation(nil, value: isAnimated)
```

### 3. animation(_:)

<p align="center">
  <img height="250" src="https://github.com/jaehoon9186/study/assets/83233720/496c484f-6531-4319-8076-912e9a9883f4">
</p>

```swift
// property
@State var size: CGFloat = 50

// in body
Circle()
    .fill(.yellow)
    .frame(width: size)


// slider,
Slider(value: $size.animation(.spring), in: 50...200, step: 50.0)
```

```
func animation(_ animation: Animation? = .default) -> Binding<Value>
```

binding 파라미터를 사용하는 ui components들에 적용가능. 위와 같이 Slider, Toggle, TextField, Stepper, Picker 등.   

(근데 binding 파라미터를 이용하지 않고, 그냥 1,2 번으로 동작하도록 구성하는것이 더 편할 것 같음.. )


