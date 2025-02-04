# gesture | 제스쳐를 동시에 simultaneousGesture

백그라운드 인터렉티브한 bottomSheet를 띄운후 닫기 위해 고민함.  

시트에 x버튼(1) + 스크롤링할때(2) + 빈공간 다른버튼탭할때(3)  

1은 구현해 주면되지만. 2,3을 매 버튼마다 정의해 주기는 번거로워보였음.  

최상위 뷰에서 simultaneousGesture 모디파이어를 사용해 조치함.  

```swift
// 상위 뷰
VStack {
    // 자식 뷰
    VStack {
        // contents
    }
    .contentShape(Rectangle())
    .gesture(TapGesture().onEnded {
        // present BottomSheet
    })

}
.contentShape(Rectangle())
.simultaneousGesture(TapGesture().onEnded {
    // dismiss bottomSheet 
}, isEnabled: /* enable 조건 */) 
.simultaneousGesture(DragGesture().onEnded { _ in
    // dismiss bottomSheet
}, isEnabled: /* enable 조건 */) )
```

탭, 드래그를 묶어 처리해도 될듯. 

---

⚠️ 위의 예 에서 바텀시트를 호출하는 버튼에서는 예외처리 하고싶었음. 같은 state프로퍼티를 변경하는 과정이기에. 예상치 못한 동작이 일어나지 않을까 싶었음.  
(뷰단에서 수행하기에 메인스레드에서 동작할것이라 race condition이 발생하지는 않을 것 같지만..) 

- highPriorityGesture < 하위뷰에 적용해도 먼저 수행하지 않음. 
- 모디파이어의 including 프로퍼티에 GestureMask < 상위뷰에서 하위뷰에 관한 것만 수행(하위뷰에서 상위뷰는 불가)
- 별도의 state 프로퍼티로 관리 <- 너무 번거로움(?)
- @GestureState,  ? 등등 더 알아봐야 할 것 같긴한데 .. 
