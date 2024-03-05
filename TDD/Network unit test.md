# Network unit test

단순히 get방식만을 test한다면 문제없겠지만, post, delete등을 테스트하려면 어떻게 할까?  

직접 서버를 이용해 테스트한다면 태스트로 인한 서버환경에 오염이 발생 할 것이다.   

또한, 네트워크가 없는 환경에서는 테스트가 가능하도록 할 순 없을까?  

Network 작업또한 unit test를 통해서 검출이 가능하다.  

// URLSession보다 서드파티인 Alamofire나 Moya가 더 추상화하여 구현된 라이브러리이기에 테스트하기에 더 용이하다고 한다.  
// 테스트를 위한 서버를 만들기도 함.  

### 참고
- [우아한 기술블로그](https://techblog.woowahan.com/2704/)
- [[Swift] Mock 을 이용한 Network Unit Test 하기](https://sujinnaljin.medium.com/swift-mock-%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-network-unit-test-%ED%95%98%EA%B8%B0-a69570defb41)
- [stack overflow](https://stackoverflow.com/questions/60089803/how-to-mock-datataskpublisher)
- [프레드 밀로 blog post](https://fredmillot.hashnode.dev/mock-session-with-typealias-urlsessiondatataskpublisheroutput)

# Session protocol 정의
```swift
protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}
```
URLSession에서 사용하는 동일한 메서드를 선언한다. 
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


# Session protocol 정의 in Combine 
```swift
protocol URLSessionProtocol {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func response(for request: URLRequest) -> AnyPublisher<APIResponse, URLError>
    func response(for url: URL) -> AnyPublisher<APIResponse, URLError>
}

extension URLSession: URLSessionProtocol {
    func response(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
    func response(for url: URL) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}
```
스택오버플로우 참고: It would probably be simpler not to mock DataTaskPublisher. Do you really care if the publisher is a DataTaskPublisher? Probably not. What you probably care about is getting the same Output and Failure types as DataTaskPublisher. So change your API to only specify




# sample data 선언. 
```json
{
  "meta": {
    "total_count": 897323,
    "pageable_count": 775,
    "is_end": false
  },
  "documents": [
    {
      "datetime": "2017-06-14T00:00:00.000+09:00",
      "contents": "내용1",
      "title": "예제1",
      "url": "https://namu.wiki/w/%EC%9D%B4%ED%9A%A8%EB%A6%AC"
    },
    {
      "datetime": "2017-06-14T00:00:00.000+09:00",
      "contents": "내용2",
      "title": "예제2",
      "url": "https://namu.wiki/w/%EC%9D%B4%ED%9A%A8%EB%A6%AC"
    },
    {
      "datetime": "2017-06-14T00:00:00.000+09:00",
      "contents": "내용3",
      "title": "예제3",
      "url": "https://namu.wiki/w/%EC%9D%B4%ED%9A%A8%EB%A6%AC"
    }
  ]
}
```
<img width="730" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/470fedec-9046-4189-a475-070b3815bf8b">

나는 JSON 파일로 생성해 번들로 접근할예정. 

# Mock object 생성

Mock Session 을 정의하여 unit test할때 생성, 주입합니다. 
프로토콜을 채택해 구현할수도있고, 아니면 URLSession을 상속받아 오버라이드할수도 있음. 

MockSession을 만드는 도중에 
session을 사용하는 APIService가 한개의 매소드에서 session을 한번만 사용하면 unit test작성하는데도 어렵지 않을 것같은데.. 
지금은 3개의 메소드에서 각각 session을 호출해서.. 각각메소드에 맞춰 리턴타입을  MockSession에서 구분해 주어야 할 것 같음.. 

```swift
class MockURLSession: URLSessionProtocol, JSONLoadable {

    enum RequestMethod {
        case fetchImage
        case fetchSearch
        case fetchSuggestion
    }

    let lastRequestMethod: RequestMethod // APIService 어떤 메소드가 요청했는지
    let makeRequestFail: Bool // request가 fail인지 아닌지. 

    init(lastRequestMethod: RequestMethod, makeRequestFail: Bool = false) {
        self.lastRequestMethod = lastRequestMethod
        self.makeRequestFail = makeRequestFail
    }

    func response(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {

        var data = Data()
        var response = HTTPURLResponse()

        if makeRequestFail {
            response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: "2", headerFields: nil)!
            return Just((data: Data(), response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }

        switch lastRequestMethod {
        case .fetchSearch:
            response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2", headerFields: nil)!
            data = loadJSON(filename: "WebSearchResponse")
            break
        default:
            response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: "2", headerFields: nil)!
            break
        }

        // (data: Data, response: URLResponse)의 named tuple
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }

    func response(for url: URL) -> AnyPublisher<APIResponse, URLError> {

        var data = Data()
        var response = HTTPURLResponse()

        if makeRequestFail {
            response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "2", headerFields: nil)!
            return Just((data: data, response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }

        switch lastRequestMethod {
        case .fetchImage:
            data = UIImage(systemName: "checkmark.seal")!.pngData()!
            response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2", headerFields: nil)!
            break
        case .fetchSuggestion:
//            let suggestion = Suggestion(suggestedWords: ["cat", "dog", "bird", "ant"])
//            data = try! JSONEncoder().encode(suggestion)
            // XML data를 전달해야함.
//            response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2", headerFields: nil)!
            break
        default:
            response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "2", headerFields: nil)!
            break
        }

        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }

}

```

# unit test

```swift
// using Mock Session
final class APIServiceTests: XCTestCase {

    var sut: APIServiceProtocol!

    override func tearDown() {
        sut = nil
    }

    func test_fetchSearch_withVaildRequest_ExpextedWebResultsCount_3() {
        // given
        sut = APIService(session: MockURLSession(lastRequestMethod: .fetchSearch, makeRequestFail: false))

        // when
        let sub = sut.getFetchSearch(type: WebSearch.self, request: URLRequest(url: URL(string: "www.test.com")!))
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error: \(error)")
                }
            } receiveValue: { webSearch in
                print("result: ", webSearch.webResults!.count)
                // then
                XCTAssertEqual(webSearch.webResults!.count, 3, "3개가 나와야함.")
            }
    }

    func test_fetchSearch_withRequestFail_Expected_Error() {
        // given
        sut = APIService(session: MockURLSession(lastRequestMethod: .fetchSearch, makeRequestFail: true))

        // when
        var receivedError: Error?
        let sub = sut.getFetchSearch(type: WebSearch.self, request: URLRequest(url: URL(string: "www.test.com")!))
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Fail")
                case .failure(let error):
                    receivedError = error
                }
            } receiveValue: { webSearch in
                XCTFail("Fail")
            }

        // then
        XCTAssertNotNil(receivedError)
    }

    func test_fetchImage_vaildRequest_expected_getImage() {
        // given
        sut = APIService(session: MockURLSession(lastRequestMethod: .fetchImage, makeRequestFail: false))

        // when
        var receivedImage: UIImage?
        let sub = sut.getFetchImage(url: URL(string: "www.test.com")!)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(_):
                    XCTFail("Fail")
                }
            } receiveValue: { image in
                receivedImage = image
            }

        // then
        XCTAssertNotNil(receivedImage)
    }

}

```


원하는 객체에 값을 담아 반환하는지? statusCode가 200번대가 아닐때 백엔드 문제일때 테스트, 원하는 fail값을 반환하는지? 
