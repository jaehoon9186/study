# Animation - built-in Animation, custom

### 참고
- [https://www.youtube.com/watch?v=IuSuHJs5-KE](https://www.youtube.com/watch?v=IuSuHJs5-KE)
- [https://www.objc.io/blog/2019/09/26/swiftui-animation-timing-curves/](https://www.objc.io/blog/2019/09/26/swiftui-animation-timing-curves/)
- [https://www.youtube.com/watch?v=86H8t0yNFA8](https://www.youtube.com/watch?v=86H8t0yNFA8)


---

Animatable protocol에 의해 애니메이팅될 대상을 결정했다면, Animataion은 시간경과에 따라 선택된 대상이 어떻게 변화할 지를 결정함.  

<p align="center">
  <img width="800" src="https://github.com/jaehoon9186/study/assets/83233720/121c4812-7092-4fab-8cd2-dd72dc89b6e3">
</p>

크게 세가지로 분류 할 수 있음. 
1. timing curve
2. Spring
3. Higher order
4. +ɑ CUSTOM (iOS 17+)



# Timing curve

<p align="center">
  <img width="1198" alt="스크린샷 2024-05-31 오후 5 41 55" src="https://github.com/jaehoon9186/study/assets/83233720/90371b6d-cf7d-4f7b-989e-327b90630c5f">
</p>

시작, 종료까지 두가지 점을 기준으로 베지어 곡선으로 애니메이션이 진행. 초기 및 최종 속도를 변경함.  

- [UnitCurve](https://developer.apple.com/documentation/swiftui/unitcurve)

### built-in timing curve presets

* linear: 일정속도로
* easeIn: 천천히 시작하고 점점 빠르게
* easeOut: 빠르게 시작하고 점점 느리게
* easeInOut: 천천히> 빠르게> 다시 느리게

default duration은 0.35 seconds, 시간을 설정할수 있는 메서드도 제공함. 

### Timing curve Custom 
- [timingCurve(_:duration:)](https://developer.apple.com/documentation/swiftui/animation/timingcurve(_:duration:))
- [timingCurve(_:_:_:_:duration:)](https://developer.apple.com/documentation/swiftui/animation/timingcurve(_:_:_:_:duration:))

두가지 방법으로 커스텀 가능. init using UnitCurve or 4 points(p1x, p1y, p2x, p2y)  


# Spring

<p align="center">
  <img width="1208" alt="스크린샷 2024-05-31 오후 5 47 23" src="https://github.com/jaehoon9186/study/assets/83233720/234d3f39-008e-4649-a276-24aa63693957">
</p>

- [Spring struct](https://developer.apple.com/documentation/swiftui/spring)

wwdc에서는 생성자로 (mass, stiffness, damping)을 사용하는 것을 old, (duration, bounce)를 new(iOS 17+)로 소개하고 있는데 문서보면 둘다 iOS 17+이라 나옴..  
일단 더 편리하게 정의 할 수 있다고 이해함.  

<p align="center">
  <img width="653" alt="스크린샷 2024-05-31 오후 6 36 56" src="https://github.com/jaehoon9186/study/assets/83233720/530cad4c-94ed-448c-8dbd-a2739080cf20">
</p>
다른 방법들도 있는 듯.

***init(duration:bounce:) ?***   
duration은 애니메이션 완료까지 시간.  
bounce, 바운스 강도, -1.0 ~ 1.0, 1.0 으론 무한 진동, 음수는 감쇠?   


***init(mass:stiffness:damping:allowOverDamping:) ?***  
mass: default 1.0, 질량, 질량이 클수록 관성이  
stiffness: 클수록 더빨리 진동?  
damping: 감쇠계수? 0이면 무한 스프링, 클수록 빨리 감소될 듯  
allowOverDamping: bool,  A value of true specifies that over-damping should be allowed when appropriate based on the other inputs, and a value of false specifies that such cases should instead be treated as critically damped.


### built-in spring presets

* smooth: 바운스 없음
* snappy: 바운스 적음
* bouncy: 바운스 많음

duration, extraBounce 각각 두가지 파라미터로 Spring을 반환하는 메서드 있음.  

### Spring custom

```swift
.onTapGesture {
    let spring1 = Spring(duration: 0.1, bounce: 0.3)

    let spring2 = Spring(
        mass: 1.1,
        stiffness: 10.0,
        damping: 1.0,
        allowOverDamping: true)

    withAnimation(.spring(spring2)) {
        isTaped.toggle()
    }
}
```

<p align="center">
  <img width="200" src="https://github.com/jaehoon9186/study/assets/83233720/b3d4ff6f-26de-44db-81b2-4abd0138040a">
</p>

### i.g. tap animation
- [https://www.youtube.com/watch?v=aPszSyqufpE](https://www.youtube.com/watch?v=aPszSyqufpE)

scale effect로 tap 할때 애니메이션을 어떻게?

```swift
struct TapAnimationView: View {
    @State var isTaped = false

    var body: some View {
        Circle()
            .fill(.yellow)
            .frame(width: 200)
            .scaleEffect(isTaped ? 0.9 : 1.0)
            .onTapGesture {
                isTaped = true

                withAnimation(.spring) {
                    isTaped = false
                }
            }
    }
}

```

<p align="center">
  <img width="200" src="https://github.com/jaehoon9186/study/assets/83233720/bd9ef59c-2656-496c-b785-8440880f84e2">
</p>


# Higher order
더욱 고차원 적인 애니메이션을 위한. 

다른 애니메이션과 결합해 다양한 효과를 만들 수 있음.  

i.g. ```.easeInOut.delay(0.5)``` 0.5초 이후 easeInOut 애니메이션 수행  

### built-in higher order

* [speed](https://developer.apple.com/documentation/swiftui/animation/speed(_:)):  
  ```func speed(_ speed: Double) -> Animation```
* [delay](https://developer.apple.com/documentation/swiftui/animation/delay(_:)):  
  ```func delay(_ delay: TimeInterval) -> Animation```
* [repeatCount](https://developer.apple.com/documentation/swiftui/animation/repeatcount(_:autoreverses:)):  
  ```func repeatCount(_ repeatCount: Int, autoreverses: Bool = true) -> Animation```
* [repeatForever](https://developer.apple.com/documentation/swiftui/animation/repeatforever(autoreverses:)):  
  ```func repeatForever(autoreverses: Bool = true) -> Animation```




# Custom (iOS 17+)
[CustomAnimation protocol](https://developer.apple.com/documentation/swiftui/customanimation)   
[https://swiftui-lab.com/swiftui-animations-part6/](https://swiftui-lab.com/swiftui-animations-part6/)   








