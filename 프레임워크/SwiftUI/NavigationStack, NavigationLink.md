
# NavigationStack, NavigationLink

### 참고 
- [navigationStack Docs](https://developer.apple.com/documentation/swiftui/navigationstack)
- [navigationLink Docs]()
- [wwdc22 The SwiftUI cookbook for navigation](https://developer.apple.com/videos/play/wwdc2022/10054/)

# 
기존 SwiftUI에선 NavigationView를 사용했었는데  
iOS 16+ 버전부턴 NavigationStack과 NavigationSplitView를 사용합니다.  

NavigationSplitView에 대해선 차후에..  
(ㄴ2,3개의 column(뎁스)를 보여줄 수 있음)


#### 기존 NavigationView
```swift
NavigationView {
  // contents
}
.navigationViewStyle(.stack)
```

#### NavigationStack ?
```swift
NavigationStack {
  // contents
}
```

# * NavigationStack


### navigation title



# * NavigationLink

NavigationStack or NavigationSplitView 내부에 위치해 있고, view를 present하기 위해 사용되는 View입니다.  
주로 리스트나 버튼과 같은 뷰와 함께 사용합니다.  

```swift
NavigationStack {

    NavigationLink {
        DetailView(info: "첫번째 디테일 뷰")
    } label: {
        HStack {
            Text("첫번째")
            Image(systemName: "magnifyingglass.circle")
        }
    }
    .padding()

    NavigationLink("두번째") { // String
        DetailView(info: "두번째 디테일 뷰")
    }

    .navigationTitle("네비게이션 타이틀")
}// navigationStack
```
<img width="398" alt="스크린샷 2024-04-16 오후 10 03 10" src="https://github.com/jaehoon9186/study/assets/83233720/c63c21e4-9884-4bf1-939b-47331a1830cb">  


### .navigationDestination, 데이터 기반 NavigationLink
데이터를 기반으로 적절한 네비게이션 링크를 탐색할 수 있습니다. 


```navigationDestination(for:destination:) ```  
```NavigationLink(titleKey:value:)``` 등.. value를 포함한 navigationLink 뷰 를 사용해야함.  

<img width="300" src="https://github.com/jaehoon9186/study/assets/83233720/0c3360bc-4383-4049-bd94-bc30c91b3996">  


```swift
// first view
struct NavigationStackStudy: View {

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("홍길동", value: "홍길동")
                NavigationLink("27", value: 27)
                NavigationLink("구마적", value: "구마적")
                NavigationLink("33", value: 33)
            }

            .navigationDestination(for: String.self) { s in
                StringView(str: s)
            }
            .navigationDestination(for: Int.self) { num in
                IntView(int: num)
            }
            .navigationTitle("Root")
        }// navigationStack
    }
}
```

```swift
// destination view 1
struct StringView: View {
    var str: String
    var body: some View {
        VStack {
            Text("String View !!")
            Text("\(str)")
            Spacer()
        }
    }
}

// destination view 2
struct IntView: View {
    var int: Int
    var body: some View {
        VStack {
            Text("Int View !!")
            Text("\(int)")
            Spacer()
        }
    }
}
```




### programmatically 하게 링크 컨트롤하기

왜 programmatically인지는 아직 모르겠으나..  
UI를 띠우는 부분에서 바인딩을 하여 동적으로 UI를 업데이트 하는 경우를 programmatically, 프로그래밍 방식? 이라고 하는 것 같다.

<img width="771" alt="스크린샷 2024-04-16 오후 11 38 11" src="https://github.com/jaehoon9186/study/assets/83233720/ee7a0768-2531-4d68-bd4a-921851c16087">


path를 지정하고, 바인딩함.  
path를 관찰.  
stack 형식으로 path에 value가 쌓이고 -> navigationDestination에 의해 적절항 뷰가 보여짐  

path에 아무것도 없는 상태가 root View, 배열처럼 append해서 뷰를 보여지게 할 수도, 초기 배열을 설정해서 미리 뎁스를 이동하던지, 다 remove해서 poptoRoot() 메서드를 구현하는 등. 다양한 응용이 가능 할 것 같습니다.  

깊은 단계의 view에서 path를 컨트롤 하려면 바인딩 된 path를 전달해야 할 것같은데.. 또 다른 방법이 있을지 고민해 보아야 할 것 같습니다.  

```swift
struct NavigationStackStudy: View {

    @State private var path = NavigationPath() // 위의 예제 에선 String, Int 타입이 다양하게 들어가서 init을 이와같이 하였음.
    // @State private var path: [Color] = []  // Docs에선 타입을 구체적으로 명시함. 

    var body: some View {
        NavigationStack(path: $path) { ... } // init(path:root:) 
}
```




# * Custom NavigationStack

### background Color 넣기 
```swift
let gradient = LinearGradient(colors:
                                    [Color.pink, Color.green],
                                  startPoint: .top,
                                  endPoint: .bottom)
var body: some View {
    NavigationStack {
        ZStack {
            // navigation stack background color set
            gradient
                .ignoresSafeArea()

            /* contents */
        } // ZStack

        .navigationTitle("타이틀")
    }// navigationStack
}
```
ZStack으로 배경색을 입힐 수 있습니다. 

### navigation bar Color
```swift
NavigationStack {
    /* contents */
    Text("d")

        .navigationTitle("네비게이션 스택")
        .toolbarBackground(.visible, for: .navigationBar) 
        .toolbarBackground(Color.indigo, for: .navigationBar)
}// navigationStack

```
navigation bar는 toolbar로 구성되어 있습니다. toolbar의 설정을 바꾸어줍시다.   
타이틀 바에 리니어그라디언트컬러를 넣는건 조금 문제가 있는것 같습니다.([stackoverflow에서 확인](https://stackoverflow.com/questions/75262480/use-gradient-for-toolbarbackground-swiftui))  
따라서 조치가 이뤄질때까진 이미지로 대체하거나, uikit을 사용하는방법을..  

### navigation bar(toolbar) item 
```swift
.toolbar {
    ToolbarItem(placement: .navigationBarLeading) { // Deprecated , iOS 17.0+ use .topBarLeading
        Text("리딩~")
    }
    ToolbarItem(placement: .navigationBarTrailing) {
        Text("트레일링~")
    }
}

.toolbarTitleMenu(content: {
    Button {
        // Action
    } label: {
        Text("메뉴1")
    }
    Button {
        // Action
    } label: {
        Text("메뉴2")
    }
})

```
<img width="405" alt="스크린샷 2024-04-16 오후 4 45 54" src="https://github.com/jaehoon9186/study/assets/83233720/51076c8d-eb36-4bab-bd36-76b898652540">

아이템의 위치 placement에 대한 다양한 옵션들은 [문서](https://developer.apple.com/documentation/swiftui/toolbaritemplacement)를 참고바랍니다. 
위 예제에는 리딩, 트레일링위치에 Text컴포넌트만 넣었습니다.    

타이틀이 .inline위치에 있을때 버튼의 모습이 보이는것 같습니다. .large 타이틀인 경우 화살표마크가 보이지 않습니다. 버튼안보여도 탭하면 메뉴나옴.

### back button title 지우기 
back버튼에 이전뷰에 대한 타이틀이 있습니다. 
이를 지우고 백버튼 이미지만 남기고 싶으면?   

<img width="381" alt="스크린샷 2024-04-16 오후 10 04 16" src="https://github.com/jaehoon9186/study/assets/83233720/3c394c0a-586f-4d37-adbf-d73886fe8314">

```swift
// in first view
NavigationLink {
    DetailView(info: "데스티네이션 뷰")
        .toolbarRole(.editor)
} label: {
    Text("이동")
}
```

또는 이동한 뷰에서 설정해주어도 된다. 
```swift
// in destination view
var body: some View {
    Text("\(info)")

    .toolbarRole(.editor)
    .navigationTitle("데스티네이션!")
    .navigationBarTitleDisplayMode(.inline)
}
```

ToolbarRole에 대한 자세한 설명은 [문서](https://developer.apple.com/documentation/swiftui/toolbarrole) 참고


### custom back button

