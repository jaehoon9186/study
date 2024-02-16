# XCTTest 메서드

자주사용되는 메서드들  
message는 옵셔널.

1. XCTAssert: 주어진 조건이 true인지 확인합니다. 실패하면 테스트가 실패합니다.
```swift
XCTAssert(expression, message)
```

2. XCTAssertEqual: 두 값이 동일한지 확인합니다.
```swift
XCTAssertEqual(value1, value2, message)
```

3. XCTAssertTrue: 주어진 조건이 true인지 확인합니다.
```swift
XCTAssertTrue(expression, message)
```

4. XCTAssertFalse: 주어진 조건이 false인지 확인합니다.
```swift
XCTAssertFalse(expression, message)
```

5. XCTAssertNil: 값이 nil인지 확인합니다.
```swift
XCTAssertNil(value, message)
```

6. XCTAssertNotNil: 값이 nil이 아닌지 확인합니다.
```swift
XCTAssertNotNil(value, message)
```

7. XCTAssertThrowsError: 특정 작업이 예외를 throw하는지 확인합니다.
```swift
XCTAssertThrowsError(expression, message)
```

8. XCTAssertNoThrow: 특정 작업이 예외를 throw하지 않는지 확인합니다.
```swift
XCTAssertNoThrow(expression, message)
```

9. XCTFail: 테스트를 강제로 실패시킵니다.
```swift
XCTFail(message)
```
