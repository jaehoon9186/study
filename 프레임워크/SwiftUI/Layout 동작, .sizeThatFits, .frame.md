# Layout 동작, .sizeThatFits, .frame.md
- [https://fatbobman.com/en/posts/layout-dimensions-1/](https://fatbobman.com/en/posts/layout-dimensions-1/)
- [https://defagos.github.io/understanding_swiftui_layout_behaviors/](https://defagos.github.io/understanding_swiftui_layout_behaviors/)
- [https://developer.apple.com/documentation/swiftui/laying-out-a-simple-view](https://developer.apple.com/documentation/swiftui/laying-out-a-simple-view)
- [https://developer.apple.com/documentation/swiftui/layout-adjustments](https://developer.apple.com/documentation/swiftui/layout-adjustments)


# 

스유에서는 부모가 자식뷰 사이즈를 결정하지 않음. 

1.부모는 자식에게 사이즈를 제안하고 -> 2.자식은 구체적인 제안을 바탕으로 사이즈를 정하고 부모에게 전달 -> 3.부모는 자식뷰를 적절한 곳에 위치. 



iOS16+ 부터 지원 가능한 커스텀 레이아웃 파트에서 간단히 알아보았으나  

어떤 방식으로 minimum, maximum, ideal 사이즈가 반환되는지 알아야겠음. 디버깅 위해. (기존의 built-in 컨테이너도 비슷한 동작, frame 모디파이어로 테스트 가능할 듯)

혼자 여러 테스트를 해보았으나 '2.부모의 제안에 맞게 반환된 사이즈'가 예상과 다른경우가 더러있어서 어려웠음.  

 

#

```swift
// in body
var body: some View {
    SimpleCustomLayout {
        Rectangle()
    }
}

// in CustomLayout
let sub = subviews[0]

print("-- Rectangle() --")
print("minimum / .zero: ", sub.sizeThatFits(.zero))
print(" 직접제안 (250, 200): ", sub.sizeThatFits(ProposedViewSize(width: 250, height: 200)))
print("ideal / .unspecified: ", sub.sizeThatFits(.unspecified))
print("maximum / .infinity: ", sub.sizeThatFits(.infinity))

```
<p align="center">
  <img width="479" alt="스크린샷 2024-06-28 오후 3 19 49" src="https://github.com/jaehoon9186/study/assets/83233720/b65d1674-5658-42b9-8d20-7a5193827208">
  <img width="674" alt="스크린샷 2024-06-28 오후 3 19 07" src="https://github.com/jaehoon9186/study/assets/83233720/11771599-58a0-42bb-8eef-74c7206e4624">
</p>


Rectangle()과 Text() 컴포넌트가 다른 결과를 보여줌. 왜그런지.. 

이런 결과를 테스트 해보며 의문이 생겨 글을 작성함.    

* .zero의 경우 (0.0, 0.0) 만 반환하는데 언제 필요한거야?

  * 처음엔 minimum size 를 반환하는것으로 이해해서, 꼭 필요한 만큼의 사이즈를 반환하는것으로 착각했음. .zero proposal의 경우 (0.0, 0.0)을 반환하는데, 이를 활용해 불필요한 컴포넌트를 숨기거나, 애니메이션에 적용하거나 등 용도로 사용하는 듯 함.

* Shape 컴포넌트는 ideal size를 (10, 10)을 반환하는데 이유는 뭐야?

* Text 컴포넌트는 구체적인 제안된 크기를 따르지 않는가? 위 예시에서 구체적으로 지정해도 (85.3, 20.3) 반환

  * 왜 그런지는 못찾겠음..    

* frame 모디파이어로 이해하기 쉬운 예제를 만들고 싶다.

#

.fixedSize() : .unspecified, ideal size


