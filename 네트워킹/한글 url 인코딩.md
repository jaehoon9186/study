# 한글 url 인코딩

url에 한글이 포함되어 있으면 nil을 반환하여 request가 불가하다.  
(한글, 띄어쓰기 등. 인식 불가함)  

아래와 같이 인코딩 작업이 필요하다.  

```swift
let url = "https://suggestqueries.google.com/complete/search?output=toolbar&hl=kor&q=커피"
let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
```

### 참고
- [apple docs](https://developer.apple.com/documentation/foundation/characterset#2902136)
- [blog](https://hongssup.tistory.com/187)
- [stackoverflow](https://stackoverflow.com/questions/32974795/url-decode-in-ios)
