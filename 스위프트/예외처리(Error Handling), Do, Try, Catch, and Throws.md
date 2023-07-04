# 예외처리(Error Handling), Do, Try, Catch, and Throws


[Docs](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/)  
[youtube link](youtube.com/watch?v=ss50RX7F7nE&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=2)
[예제 프로젝트](https://github.com/jaehoon9186/study/tree/main/CODE/ERROR%20HANDLING)

실행중인 프로그램의 비정상적인 종료를 막고, 상태를 정상상태로 유지하는 것이 목적

## 순서
1. 오류 정의
2. 오류 던지기 & 오류 처리하기 
3. 기타 활용

<br/>
<br/>

## 1. 오류 정의 ( 옵셔널 )
```swift
enum TestError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
    case notActive
}
```

<br/>
<br/>

## 2. 오류 던지기 & 오류 처리하기
다양한 방법들을 순차적으로 알아보자~

<br/>
  
#### ✅ Tuple로 던지기~
> 던지기
```swift
func getTitle() -> (title: String?, error: Error?) {
    if isActive {
        return ("new text", nil)
    } else {
//            return (nil, URLError(.badURL))
        return (nil, TestError.notActive)
    }
}
```
성공, 실패의 경우 모두 튜플로 불필요한 정보까지 보낸다 더 개선한다면? -> result로 전달해보자


> 처리하기
```swift
let returnedValue = manager.getTitle()
if let newTitle = returnedValue.title {
    self.text = newTitle
} else if let error = returnedValue.error {
    self.text = error.localizedDescription
}
```

<br/>
  
#### ✅ Result로 던지기~
> 던지기
```swift
func getTitle2() -> Result<String, Error> {
    if isActive {
        return .success("new text")
    } else {
        return .failure(TestError.notActive)
    }
}
```
Result<Any, <#Failure: Error#>>
성공, 실패 두가지 모두를 반환 하지 않는다. 한가지의 결과만을 반환.

> 처리하기
```swift
let result = manager.getTitle2()

switch result {
case .success(let newTitle):
    self.text = newTitle
case .failure(let error):
    self.text = error.localizedDescription
}
```

<br/>
  
#### ✅ throws로 던지기~ 
> 던지기
```swift
func getTitle3() throws -> String {
    if isActive {
        return "new text"
    } else {
        throw TestError.notActive
    }
}
```
함수 / 함수명 / 리턴이 실패한다면 throws error / 리턴은 스트링으로

> 처리하기
```swift
do {
    // 얻을려고 시도한다. 에러가 발생하면 어디서 잡지?
    let newTitle = try manager.getTitle3()
    self.text = newTitle
} catch let error {
    self.text = error.localizedDescription
}
```
try 얻으려고 시도한다. 함수가 error를 발생하면 catch 문에서 처리한다. 
  
```swift
// catch : 암시적으로 작동하도록도 가능하다.
do {
  //
{ catch {
  self.text = error.localizedDescription
}
```


<br/>
<br/>

## 3. 기타 활용 
<br/>

> do-catch 여러번의 try?
```swift
do {
            // 얻을려고 시도한다. 에러가 발생하면 어디서 잡지?
            let newTitle = try manager.getTitle3()
            // 여러번의 try 가 가능하지면 한번 실패하면 catch로
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
            self.text = newTitle
        } catch let error {
            self.text = error.localizedDescription
        }
```
<br/>

> 옵셔널 try
```swift
let newTitle = try? manager.getTitle3()
```
catch로 오류를 전달하지 않는다. do-catch 문이 필요없음.   
따로 처리가 필요없는 error나 서드파티같은것들 옵셔널로 처리하여 절약할수 있다.  
<br/>

> forced unwrapping try
```swift
let newTitleUnwrapping = try! manager.getTitle3()
```
강제 언래핑, 권장되지 않음.  
error throw 비활성화한다.  
오류가 발생하면 런타임 에러가 발생한다.  
