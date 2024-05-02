# @Environment, custom environment

### 참고
- [docs / Environment values](https://developer.apple.com/documentation/swiftui/environment-values)
- [https://www.youtube.com/watch?v=rl7xj5usTzk](https://www.youtube.com/watch?v=rl7xj5usTzk)

# @Environment?
Environment property wrapper를 사용해 환경변수에 대한 정보를 get할 수 있다.  

형식은? ```@Environment(\.colorScheme) var ColorScheme: ColorScheme```   
keypath( KeyPath<EnvironmentValues, Value> )로 환경변수에 접근하고, 해당 property로 view의 구성을 사용자가 정의할 수 있다.   



```.environment()``` 모디파이어를 사용해 자식으로 변경된 환경변수를 전달할 수도 있다. 
```swift
struct first: View {
    var body: some View {
        second()
            .environment(\.colorScheme, .dark)
    }
}

struct second: View {
    @Environment(\.colorScheme) var colorSchome: ColorScheme
    var body: some View {
        if colorSchome == .light {
            // lightView()
        } else {
            // darkView()
        }
    }
}
```
```swift
HStack { // 3 2 1 로 보여짐 
    Text("1")
    Text("2")
    Text("3")
}
.environment(\.layoutDirection, .rightToLeft)
```



# built-in environment values / EnvironmentValues 
- [https://developer.apple.com/documentation/swiftui/environmentvalues](https://developer.apple.com/documentation/swiftui/environmentvalues)

```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    public var colorScheme: ColorScheme
    public var colorSchemeContrast: ColorSchemeContrast { get }
}
```
colorSceme이 예제로 나와서.. 내부에 어떻게 구현이 되어있는가 보았음. 

다른 속성들도 extension 기본구현으로 구현되어있다.  

우리 또한 이처럼 custom EnvironmentValue 를 정의할 수 있음. 


# Custom? / EnvironmentKey protocol 
- [https://developer.apple.com/documentation/swiftui/environmentkey](https://developer.apple.com/documentation/swiftui/environmentkey)  

전역으로 사용할 수 있는 AppColor를 정의해 보자.  
먼저 관리하기 편하기 그룹을 만들어준다.  
<p align="center">
  <img width="277" alt="스크린샷 2024-05-02 오후 9 39 20" src="https://github.com/jaehoon9186/study/assets/83233720/0522d86f-6f1e-42f8-9289-1cb6dcd93d2a">
</p>




</br>
</br>
  
1. Custem EnvironmentKey 구현 / EnvironmentKey 프로토콜 채택

```swift
struct AppColorKey: EnvironmentKey {
    static var defaultValue: Color = .red
}
```
(associatedtype 이 프로토콜에 정의되있어 typealiases를 정의해야하는데 구체적 타입을 명시해여 생략가능함.)

</br>
</br>
  
2. 새로운 environment value 정의

```swift
extension EnvironmentValues {
    var appColor: Color {
        get {
            self[AppColorKey.self]
        }
        set {
            self[AppColorKey.self] = newValue
        }
    }
}
```
```swift
// in view, propertys
@Environment(\.appColor) var appColor
```
</br>
</br>
  
3. ***+⍺*** View extension
```swift
extension View {
    func appColor(_ color: Color) -> some View {
        environment(\.appColor, color)
    }
}
```
view 프로토콜을 채택한 구현체에서 쉽게 적용이 가능하도록한다. 

</br>
</br>
  
+  
유튭영상에선 Custom Environment를 활용해, 멤버십단계에 따라 테마컬러를 다르게 적용하는 예제가 소개되었음. 

간단한 흐름으로는,  
빌더패턴을 적용한 struct를 정의하고,  
로컬데이터로부터 멤버쉽단계를 가져와 custom environmentvalue를 set -> 현재 environment에 맞는 Color 테마가 적용됨.  
  
(SwiftUI에서 자주사용된다는 빌더패턴. 익숙해지자.)



## 궁금증 해소 
### custom environment value를 정의할 때, getter, setter에 [] 브라켓은 뭘 말하는거야?
```swift
public struct EnvironmentValues : CustomStringConvertible {
    // 생략 
    public subscript<K>(key: K.Type) -> K.Value where K : EnvironmentKey
}
```
EnvironmentValues의 정의를 보면 subscript로 정의 되었음을 알 수 있다. 배열이랑, 딕셔너리도 이와같은 subscript로 구현되어있음. subscript에 대해 잘 몰랐어서.. 
뭐지 싶었다.  

