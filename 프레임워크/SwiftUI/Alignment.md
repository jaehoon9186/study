# Alignment

- [Alignment docs](https://developer.apple.com/documentation/swiftui/alignment)
- [alignmentGuide(_:computeValue:) docs](https://developer.apple.com/documentation/swiftui/view/alignmentguide(_:computevalue:)-9mdoh)
- [overlay(alignment:content:) docs](https://developer.apple.com/documentation/swiftui/view/overlay(alignment:content:))

view의 위치를 조절해보자

# HStack, VStack, ZStack / Container Alignment

```swift
VStack(alignment: .leading, spacing: 10) {
    /* contents */
}
```

<p align="center">
  <img height="154" alt="스크린샷 2024-04-23 오전 11 36 03" src="https://github.com/jaehoon9186/study/assets/83233720/d7d2e6c8-f104-4eb2-b113-171cc0e19234">
  <img height="154" alt="스크린샷 2024-04-23 오전 11 36 39" src="https://github.com/jaehoon9186/study/assets/83233720/d68dbfed-691e-4c41-99db-511e6940c2db">   
</p>



# frame Alignment, overlay Alignment
```swift
VStack(spacing: 10) {
    Text("")
    Text(" ")
    Text("  ")
    Text("   ")
    Text("    ")
    Text("     ")
}
.frame(width: 200, height: 300, alignment: .leading)
.overlay(alignment: .bottomTrailing) {
    Text("VSTACK")
        .padding(10)
}
.background(.cyan)
.foregroundColor(.white)
```
<p align="center">
  <img width="223" alt="스크린샷 2024-04-23 오후 12 05 20" src="https://github.com/jaehoon9186/study/assets/83233720/38bfbfba-64c6-4a4b-91cf-39b71fc81efd">
</p>


# Alignment Guide
- [apple article: Aligning views within a stack](https://developer.apple.com/documentation/swiftui/aligning-views-within-a-stack)
- [apple article: Aligning views across stacks](https://developer.apple.com/documentation/swiftui/aligning-views-across-stacks)
- [wwdc19 Building Custom Views with SwiftUI](https://developer.apple.com/videos/play/wwdc2019/237/), 19분부터  
- [Alignment in SwiftUI: Everything You Need to Know](https://fatbobman.com/en/posts/layout-alignment/)

Alignment Guide? 스택뷰의 내부, 하위 뷰에 있는 뷰들의 기준이 되는 가이드?

이를 이용해 stack 내부의 뷰컴포넌트의 위치를 조정할 수 있음.
<p align="center">
  <img width="1232" alt="스크린샷 2024-04-25 오후 3 15 02" src="https://github.com/jaehoon9186/study/assets/83233720/941ff5f6-f4a6-4e31-9079-28894920d30f">
</p>




# 

