# Network unit test

단순히 get방식만을 test한다면 문제없겠지만, post, delete등을 테스트하려면 어떻게 할까?  

직접 서버를 이용해 테스트한다면 태스트로 인한 서버환경에 오염이 발생 할 것이다.   

또한, 네트워크가 없는 환경에서는 테스트가 가능하도록 할 순 없을까?  

Network 작업또한 unit test를 통해서 검출이 가능하다.  

// URLSession보다 서드파티인 Alamofire나 Moya가 더 추상화하여 구현된 라이브러리이기에 테스트하기에 더 용이하다고 한다.  

### 참고
- [우아한 기술블로그](https://techblog.woowahan.com/2704/)

# Session protocol 정의
```swift
protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}
```
combine을 사용해 퍼블리셔를 반환하도록 이미 구현하였기때문에 dataTaskPublisher 메서드를 프로토콜에 다시 정의하였다.  

URLSessionProtocol을 URLSession에서 채택하고, session을 외부에서 주입받도록한다.  

```swift
class APIService: APIServiceProtocol {

    let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    // ..
}
```

구현체에서는 프로토콜로 정의를 함으로서 테스트더블 오브젝트로 교체가능하도록 한다. 

# Mock object 생성

# unit test
