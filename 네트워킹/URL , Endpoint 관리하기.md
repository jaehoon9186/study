# URL 관리하기. 

조금 더 가독성이 좋아지고, 한군데에서 정의하기에 유지보수에 용이해질 것 같습니ㅏㄷ. 

### 참고
- [youtube video](https://www.youtube.com/watch?v=2B4ROZHsaCs)
- [블로그 포스트](https://velog.io/@sookim-1/iOS-URL%EB%B0%8F-endpoint%EA%B4%80%EB%A6%AC%ED%95%98%EA%B8%B0)

# I.g.
카카오 검색 API를 이용하여 여러 곳에서 네트워크 요청이 이루어져 이것을 가독성이 좋게 할 수 있는 방법을 찾다 알게 되었습니다.  
  
정의된 enum 프로퍼티 선택하고(API상에서 query는 필수), url get프로퍼티를 이용해 옵셔널 URL을 반환합니다.  
반환된 url중 한글이 있을 수 있으니 인코딩 과정을 거칩니다.  

```swift
enum EndPoint {
    case web(query: String)
    case video(query: String)
    case image(query: String)

    var url: URL? {
        let baseURL = "https://dapi.kakao.com/v2/search"

        switch self {
        case .web(let query):
            let str = "\(baseURL)/web?query=\(query)"
            return URL(string: str.encodeURL()!)
        case .video(let query):
            let str = "\(baseURL)/vclip?query=\(query)"
            return URL(string: str.encodeURL()!)
        case .image(let query):
            let str = "\(baseURL)/image?query=\(query)"
            return URL(string: str.encodeURL()!)
        }
    }
}
```
