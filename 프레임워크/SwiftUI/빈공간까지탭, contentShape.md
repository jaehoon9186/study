# 빈공간까지탭, contentShape


- [https://developer.apple.com/documentation/swiftui/view/contentshape(_:eofill:)](https://developer.apple.com/documentation/swiftui/view/contentshape(_:eofill:))

```swift
VStack {
    // content
}
.contentShape(Rectangle())
.onTapGesture {
    print("Tapped")
}
```

내용중 spacer같은 빈공간은 tap영역으로 인식하지 않음. 

contentShape를 사용하면 영역 전체를 탭영역으로 설정할 수 없음.

shape 타입으로 특정영역으로도 지정할수 있음.  

문서보면 eoFill 파라미터도 있는데 홀/짝 을기준으로 탭영역을 설정할 수 있는것 같음.  
