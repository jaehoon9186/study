# TabView




# Custom TabView

### background color 수정하기 
[질문글](https://developer.apple.com/forums/thread/121799)을 참고

기본적으로 투명해서 tabItem View가 전영역을 차지하게 된다면 뒤로 비친다.

<img width="308" alt="스크린샷 2024-04-18 오후 6 23 53" src="https://github.com/jaehoon9186/study/assets/83233720/8ba37650-2d26-48de-870b-3c78aafa176d">
<img width="308" alt="스크린샷 2024-04-18 오후 6 52 41" src="https://github.com/jaehoon9186/study/assets/83233720/db7a00d1-3424-4e62-bf8e-18b9f515937d">  

이럴땐 1. 그룹으로 지정해서 tabbar로 사용되는 toolbar를 설정해 주거나, 2. view 생성자에서 appearance를 이용 수정할 수 있다. 
또는 view lifecycle에서 설정을 해줘도 ㅇㅋ. 

```swift
struct TabViewStudy: View {

    var body: some View {

        TabView {
            Group {
                /* contents: tabbarItems */
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.white, for: .tabBar)
        } // TabView
        
    } // body
}
```

```swift
struct TabViewStudy: View {

    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        TabView {
            /* contents: tabbarItems */

        } // TabView
    } // body
}
```

appearance() 메소드에 대해 궁금했다. swiftui documentation에서도 찾을 수 가 없어서.. 
uikit에서는 같은 메소드가 존재하는데.. 같은건가? 같다면 왜 swiftUI에서도 접근가능한건지.. 다르다면 왜 공식문서에선 찾을 수 없는지.. 

[custom tabView swiftUi](https://www.swiftyplace.com/blog/tabview-in-swiftui-styling-navigation-and-more) 포스트 에서는 
ios15 or earlier 버전에서 appearance()를 사용한다고 하니.. 추측으론 이전에 사용된 방법인듯하나.. 확실치 않다. 이전 문서를 찾아봐야하는데 어디서 봐야하는지 모르것음. 


chatGPT는,  
"
appearance() 메서드가 SwiftUI에 존재하는 이유는 내부 구현 요구 사항이나 UIKit과의 호환성과 관련이 있을 수 있습니다. 그러나 이 메서드의 존재는 개발자가 해당 메서드를 사용하도록 Apple이 공식적으로 지원하거나 보증하는 것을 의미하지는 않습니다.

SwiftUI에서 appearance() 메서드가 존재하는 이유는 내부 구현 필요에 따른 것이거나 UIKit과의 호환성을 유지하기 위한 것일 수 있습니다. 그러나 이 메서드의 존재는 개발자가 해당 메서드를 사용하도록 Apple이 공식적으로 지원하거나 보증하는 것을 의미하지는 않습니다.
"  
라고함. 정확한정보인지는 모르지만. 사용에 주의해야함은 확실하다. 문서에 없으니. 



### foregroundColor 설정하기 



