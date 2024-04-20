# TabView
- [TabView Docs](https://developer.apple.com/documentation/swiftui/tabview)
- [SwiftUI Tabview Tutorial: How to Customize the Tab Bar](https://www.swiftyplace.com/blog/tabview-in-swiftui-styling-navigation-and-more)

### 기본 구성 
```swift
// https://developer.apple.com/documentation/swiftui/tabview
TabView {
    ReceivedView()
        .badge(2)
        .tabItem {
            Label("Received", systemImage: "tray.and.arrow.down.fill")
        }
    SentView()
        .tabItem {
            Label("Sent", systemImage: "tray.and.arrow.up.fill")
        }
    AccountView()
        .badge("!")
        .tabItem {
            Label("Account", systemImage: "person.crop.circle.fill")
        }
}
```

### programmatic 하게. 

@State 프로퍼티를 활영해 동적으로 컨트롤 할 수 있다. 

```.tag()``` 모디파이어와 ```tabview init(selection:content:)```이니셜라이저   

```swift
struct TabViewStudy: View {

    @State private var selectedIndex: Int = 0

    var body: some View {
        TabView (selection: $selectedIndex) {
            Group {
                SearchView()
                    .tabItem {
                        Label("search", systemImage: "magnifyingglass")
                    }
                    .tag(0)

                HomeView()
                    .tabItem {
                        Label("home", systemImage: "house")
                    }
                    .tag(1)

                StarView()
                    .tabItem {
                        Label("mark", systemImage: "star")
                    }
                    .tag(2)
            } 
            .toolbarBackground(.visible, for: .tabBar)

            .onChange(of: selectedIndex) { newValue in
                print("\(newValue)")
            } // 템뷰 선택시 이벤트핸들링하는 경우

        }// TabView
    }// body
}
```

int type이 아닌 문자열도 ㅇㅋ,


### tabViewStyle(_:)
기본적으로 잘 알고 있는 스타일이 default인 .automaitc 타입의 스타일이다.  
TabView를 pagingView 형태로 바꿀수 있도록 제공하는데 

```swift
TabView {
    /* contents */
}
.tabViewStyle(.page) // 페이징
.edgesIgnoringSafeArea(.all)
```
<img width="300" alt="스크린샷 2024-04-19 오후 3 43 19" src="https://github.com/jaehoon9186/study/assets/83233720/31fc8cba-f3dd-4a50-8bfa-8a7d7959dd60">

스와이프해서 화면을 전환할 수 있고, tabItem에서 지정한 sf symbol이 조그맣게 나옴(안넣으면 점만나옴). 시스템이미지 외의 이미지도 가능한가 모르겠음.  
단, contents 뷰에서 safearea를 무시하는 전체화면으로 하도록 해도, .page로 설정했을땐 safeArea에만 보여진다. TabView에 .edgesIgnoringSafeArea(.all) 처리를 해줘야함. [stackOverflow](https://stackoverflow.com/questions/62593923/edgesignoringsafearea-on-tabview-with-pagetabviewstyle-not-working)

```swift
TabView {
    /* contents */
}
.tabViewStyle(.page(indexDisplayMode: .always))
.indexViewStyle(.page(backgroundDisplayMode: .always))
```

<img width="266" alt="스크린샷 2024-04-19 오후 8 04 00" src="https://github.com/jaehoon9186/study/assets/83233720/bdeb542e-1a1b-4b59-b2b0-abfe1580240c">


### Badge
<img width="220" alt="스크린샷 2024-04-19 오후 3 54 02" src="https://github.com/jaehoon9186/study/assets/83233720/8d1d08f0-651e-4e03-9260-b36defbd3ede">

```swift
TabView {
    SearchView()
        .tabItem {
            Label("search", systemImage: "magnifyingglass")
        }
        .badge(1)
    /* conents */
}
```

문자열이나 숫자로 벳지를 달아줄수 있다. 단, 숫자로 0을 넣으면 벳지 안보이게됨. 



# Custom TabView

### background color 수정하기 
[질문글](https://developer.apple.com/forums/thread/121799)을 참고

기본적으로 투명해서 tabItem View가 전영역을 차지하게 된다면 tabview뒤로 비친다.

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



### foregroundColor, tint Color 설정하기 

```swift
TabView {
    /* contents */
}
.tint(Color.red)
```

```swift
// iOS15 and earlier
TabView {
   /* contents */
}
.onAppear() {
    UITabBar.appearance().barTintColor = UIColor(.indigo)
}
```

```swift
// badge Color
UITabBarItem.appearance().badgeColor = .blue
```


### 탭바 커스텀하기 
[SwiftUI Custom TabView With Custom Add Button](https://www.youtube.com/watch?v=v19fln0e_qQ)

