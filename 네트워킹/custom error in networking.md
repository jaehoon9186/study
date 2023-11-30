# custom error in networking.md

네트워크에서 발생할 에러를 핸들링하기 위해, 사용자 정의 에러를 만들어 봅니다. 

### 참고
- [apple docs, Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/)
- [apple docs, Error Protocol](https://developer.apple.com/documentation/swift/error)
- [lecture, Create, Throw, and Handle Custom Errors In Swift](https://www.advancedswift.com/custom-errors-in-swift/)

# enum ? class/struct ?

일반적으로 error는 복잡한 구조를 가지고 있지 않기 때문에, enum으로도 구현가능합니다. 또한 더욱 간결히 표현 가능합니다.  
만약 특정 값을 저장한다거나 하는 경우 class/struct를 사용하거나 enum과 같이 사용하거나 하는 경우도 있는 것 같습니다.  
(error protocol에 대한 공식문서를 보면 관련된 예제가 있음)  
  
특정 값과 같이 핸들링 하기위해서 enum에서는 연관값(associated value)을 사용할 수 있습니다.  

# Custom Error 정의 
네트워크 작업 중에 발생할 문제들은 대략 이하와 같습니다. 
* 유효하지 않는 URL
* 요청중 실패한 경우 (error != nil) // transportError(Error)
* response statusCode가 오류인경우   
  server-side에서 발생하는 error는 response에서 판단할 수 있습니다.   
  (필요하다면 구체적으로 정의?)  
* data가 없는 경우
* decode에 실패한 경우 
등이 있습니다.

```swift
enum APIError: Error {
    case invalidURL
    case transportError(Error)
    case badResponse(stateCode: Int)
    case missingData
    case parsingError
    case unknown
}
```


# advanced

error들은 localizeddescription 프로퍼티를 이용하여 error에 대한 정보를 이해하기 쉽게 볼 수 있습니다.   
커스텀으로 정의된 error에도 위와 같은 기능을 구현할 수 있습니다.  
1. get 프로퍼티를 이용하는 법
2. CustomStringConvertible 프로토콜을 채택하여 description 프로퍼티를 정의하는 법
3. LocalizedError 프로토콜을 이용해 errorDescription 프로퍼티를 정의하는 법 [How to provide a localized description with an Error type in Swift?](https://www.tutorialspoint.com/how-to-provide-a-localized-description-with-an-error-type-in-swift)

또한 이를 이용해 사용자에게 피드백을 주는 부분, 디버깅을 위한 부분을 나누어 정의해 놓을 수 있습니다.  

```swift
enum APIError: Error, CustomStringConvertible {

    case invalidURL
    case transportError(Error)
    case badResponse(stateCode: Int)
    case missingData
    case parsingError
    case unknown

    var localizedDescription: String {
        // 사용자에게
        switch self {
        case .badResponse(_):
            return "죄송합니다. 서버에 문제가 있습니다."
        case .invalidURL, .transportError(_), .parsingError:
            return "죄송합니다. 문제가 발생했습니다."
        case .missingData:
            return "요청하신 결과가 없습니다."
        case .unknown:
            return "관리자에게 문의하세요"
        }
    }

    // CustomStringConvertible 채택
    var description: String {
        // 디버깅
        switch self {
        case .invalidURL:
            return "ERROR: 유효하지 않은 URL"
        case .transportError(error: let error):
            return "ERROR: API 요청 실패, \(error)"
        case .badResponse(stateCode: let stateCode):
            return "ERROR: 서버에러 \(stateCode)"
        case .missingData:
            return "ERROR: 데이터 없음"
        case .parsingError:
            return "ERROR: data parsing 실패"
        case .unknown:
            return "ERROR: 기타 에러"
        }
    }
}

```



