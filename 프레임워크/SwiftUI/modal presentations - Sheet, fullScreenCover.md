# modal presentations - Sheet, fullScreenCover

### 참고
- [HIG Sheet](https://developer.apple.com/design/human-interface-guidelines/sheets)
- [sheet docs](https://developer.apple.com/documentation/swiftui/view/sheet(ispresented:ondismiss:content:)#parameters)
- [Multiple Sheets in a SwiftUI View | Continued Learning #7 / youtube](https://www.youtube.com/watch?v=8rCtYoG9JIM)

# Sheet?
modal presentations 방법중 하나이기에 HIG에서 제공한 Modality의 특징?([HIG Modality](https://developer.apple.com/design/human-interface-guidelines/modality))을 지키도록
합니다.  

어떤 상황에 사용하는 것이 좋을까? 
사용자에게 특정정보를 요청하는경우, 상위뷰로 이동하기 전에 완료할 수 있는 간단한 작업을 제시하는 상황에 사용하는 것이 좋다.  
i.g. 파일첨부, 이동, 저장위치 선택 등.   

  
만약 상위뷰에 영향을 주는 경우는 nonModalsheet를 사용하길 권장.   
(hig에서 말하는 nonModalsheet? sheet가 화면에 있는경우, 닫지 않고 sheet에서 발생한 유저액션이 즉시 상위뷰에 반영되는 것을 말하는 것 같음.)
<p align="center">
  <img width="250" alt="스크린샷 2024-04-26 오후 4 48 03" src="https://github.com/jaehoon9186/study/assets/83233720/1d79b20d-0660-4b9e-a44c-30e850a6c086">
</p>

# Sheet 구현

<p align="center">
  <img width="200" alt="스크린샷 2024-04-26 오후 4 48 03" src="https://github.com/jaehoon9186/study/assets/83233720/e347a151-d4df-4d18-82b5-df29c5ef8c57">
</p>

```swift
// State property
@State private var showSheet: Bool = false

// in body
.sheet(isPresented: $showSheet) {
    DetailSheetView() 
}
```

```
sheet(isPresented:onDismiss:content:)

func sheet<Content>(
    isPresented: Binding<Bool>,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> Content
) -> some View where Content : View
```
문서에 위와 같이 정의되어있다. 각각의 파라미터를 보면. 
* isPresented: bool값으로 state property를 정의한후 바인딩 ㄱ. ture일 때 content가 sheet로 보여짐. sheet 닫으면 false로 됨. 
* onDismiss: default는 nil로 sheet가 닫힐때 실행할 클로저가 있다면 정읙
* content: @ViewBuilder 키워드, 여러 view들이 생성되는 클로저를 전달받음.


위의 메서드 외에도 item을 바인딩해 sheet를 구현하는 모디파이어 메서드가 있는데 문서에 보면 자세히 나와았음. ㄱㄱ


# sheet 사이즈 

<p align="center">
  <img width="250" alt="스크린샷 2024-04-26 오후 4 20 29" src="https://github.com/jaehoon9186/study/assets/83233720/2b9f4d0d-8fdf-429a-a60d-05740523c229">
</p>

```presentationDetents(_ detents: Set<PresentationDetent>)```메서드로 sheet의 사이즈를 조절할수 있다.  
default는 PresentationDetent.large 사이즈.  

detent는 멈춤쇠라는 뜻

사용자가 sheet를 상하로 드래그할때 set에 정의된 detent위치에서 멈추면 고정된다. 

<p align="center">
  <img width="200" alt="스크린샷 2024-04-26 오후 4 48 03" src="https://github.com/jaehoon9186/study/assets/83233720/2cc1cdde-8957-4c74-b24e-2d1b2482d804">
</p>

```swift
.presentationDetents([.medium, .large])
```


프로그래밍 방식도으로 detent를 조정가능하다. [presentationDetents(_:selection:)](https://developer.apple.com/documentation/swiftui/view/presentationdetents(_:selection:))참고
```swift
// property
@State private var settingsDetent = PresentationDetent.large

// in body
.presentationDetents([.medium, .large], selection: $settingsDetent)
```
이때는 selection에 바인딩되는 detent가 detent set에 있어야함. 



이외에도 커스텀 사이즈로 detent를 정의할 수 있는데, 문서를 참고해보자. [커스텀 detent docs](https://developer.apple.com/documentation/swiftui/custompresentationdetent)  



# Dismiss
화면을 닫는 방법은?

1. 기본?  
  : 상단의 인디케이터를 드레그하거나, sheet 외부 탭
2. State property를 false로   
  : @State property를 false로.. sheet에 유저액션을 받아야한다면 overlay등으로 버튼을.
3. environment property 활용  
  : [How to make a view dismiss itself](https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-view-dismiss-itself)  
  ```swift
    // property
    @Environment(\.dismiss) var dismiss

    // in body
    dismiss()
  ```


# 기타
### sheet 상단 인디케이터가 없음. 보이게 하고싶어요
iOS 16+, 하나의 detent 만 있다면 드래그 인디케이터가 안보이는듯 하다. 하단의 모디파이어 실행
```.presentationDragIndicator(.visible)```

### multiple sheet, 방법 및 주의사항
- [Multiple Sheets in a SwiftUI View | Continued Learning #7 / youtube](https://www.youtube.com/watch?v=8rCtYoG9JIM)
