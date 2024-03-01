# XCTest 살펴보기

### 참고 
- [docs / Set Up and Tear Down State in Your Tests](https://developer.apple.com/documentation/xctest/xctestcase/set_up_and_tear_down_state_in_your_tests)
- [야곰 코스](https://yagom.net/courses/unit-test-%ec%9e%91%ec%84%b1%ed%95%98%ea%b8%b0/lessons/unit-test-%ec%9e%91%ec%84%b1%ed%95%98%ea%b8%b0/topic/%ed%85%8c%ec%8a%a4%ed%8a%b8-%ed%8c%8c%ec%9d%bc-%ec%bd%94%eb%93%9c-%ec%82%b4%ed%8e%b4%eb%b3%b4%ea%b8%b0/)

###
```swift
import XCTest
@testable import SearchApp 

final class SearchAppAPIServiceTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }
}
```

unit test 클래스를 생성하게 되면  
위와 같이 XCTest 프레임워크를 임포트, 테스트할 타겟 임포트함. 

# setUp(), tearDown()
여러개의 test 메서드가 존재할 때 sut를 초기화, 해제하는 메서드임. 

setUp() > test1() > tearDown() > setUp() > test2() .. 순  

이와 같이 하는 이유는 모든 테스트를 같은 조건 속에서 할 수 있도록 하기 위해.  

setUpWithError(), tearDownWithError() 와 같이 에러 발생시 throw할 수 있도록 정의할 수도 있음.  

# test 함수 

test할 메서드는 메서드명을 test라고 적어줘야함.  

네이밍을 한글로 적기도하고, 어떤테스트를 하는지 결과는 어떻게 나와야하는지 이해하기 쉽도록 적어주자.  

```swift
    func testExample() {
        // given

        // when

        // then
    }
```

given, when, then 으로 BDD(Behavior Driven Development) 테스트 방식을 사용하여 예상대로 나오는지 확인하는 방법을 사용함.  
then에서 Test 함수 사용. 
