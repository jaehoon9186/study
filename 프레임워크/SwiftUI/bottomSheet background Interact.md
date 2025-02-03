# bottomSheet background Interact

지도 앱처럼 배경과 상호작용하는 바텀시트를 만들고 싶었음. 

```swift
.sheet(isPresented: $selectedBeatManager.isBeatEditPresented, onDismiss: {
      selectedBeatManager.unselectBeat()
  }) {
      if let selectedBeatVM = selectedBeatManager.selectedBeatViewModel {
          SelectedBeatView(beatViewModel: selectedBeatVM)
              .id(selectedBeat.id)  // 새로운 ID를 부여하여 강제 리렌더링
              .presentationDetents([.fraction(0.2)]) // 사이즈
              .presentationBackgroundInteraction(.enabled) // 배경 상호작용. 
              .presentationDragIndicator(.visible)
      }
}
```

뷰에 뷰모델을 주입해서 바텀시트를 띄우는 구조로 구성했는데. 

시트띄울 바인딩된 bool값이 트루로 고정인 상황이라 리렌더가 안됨.  

.id 모디파이어를 사용해 해결함.  

스유가 변경됬다는것을 감지할수있도록 해주고 리랜더링 될 수 있도록.  
