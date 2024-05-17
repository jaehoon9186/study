# Future

### 참고
- [docs / Future](https://developer.apple.com/documentation/combine/future)
- [https://www.youtube.com/watch?v=Eu0uTzqnLrE&list=PL0dIyZBNMaJFcxtZw8Fou8dt8ZgGj0NZX&index=9](https://www.youtube.com/watch?v=Eu0uTzqnLrE&list=PL0dIyZBNMaJFcxtZw8Fou8dt8ZgGj0NZX&index=9)
- [https://www.youtube.com/watch?v=yCGbhbFK8sY&t=981s](https://www.youtube.com/watch?v=yCGbhbFK8sY&t=981s)
- [https://manishpathak99.medium.com/future-and-promise-in-swift-combine-framewrk-c9ff2da4302a](https://manishpathak99.medium.com/future-and-promise-in-swift-combine-framewrk-c9ff2da4302a)

# Future 
<p align="center">
  <img width="1092" alt="스크린샷 2024-05-14 오후 4 53 19" src="https://github.com/jaehoon9186/study/assets/83233720/d3747ede-4d4f-4163-92df-36d49bc8d953">
</p>

built-in publisher 중 하나임. Future를 사용하면 단일 값을 비동기 적으로 생성, 성공유무(finish or fail)와 함께 반환 가능. 

비동기 프로그래밍을 위해 사용. 네트워크, 미디어 다운로드 등..  

기존에는 @escaping closure(aka. completionHandler)로 비동기 프로그래밍을 하였음. 이를 Future를 사용해 PUblisher로 변환 가능 


</br></br>
 
이전. 
```swift
func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> ()) {
    URLSession.shared.dataTask(with: url) { Data, response, error in
        completionHandler("New data", nil)
    }
    .resume()
}

// 호출
getEscapingClosure { [weak self] returnedvalue, error in
    self?.title = returnedvalue
}
```

</br></br>

Future 적용. 
```swift
func getFuturePublisher() -> Future<String, Error> {
    Future { promise in
        // getEscapingClosure 위의 메서드와 같음. 
        self.getEscapingClosure { returnedvalue, error in
            if let error = error {
                promise(.failure(error))
            } else {
                promise(.success(returnedvalue))
            }
        }
    }
}

getFuturePublisher()
    .sink { _ in
    
    } receiveValue: { [weak self] returnedValue in
        self?.title = returnedValue
    }
    .store(in: &cancellables)

```

publisher로 반환하기때문에 다양한 오퍼레이터들과도 결합이 가능함.  



</br></br>

추가 예제.  

4초 후 문자열을 반환하는 메서들을 정의한다면 
```swift
// ERROR
func doSomething() -> String {
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        return "new String"
    }
}
```

이렇게 에러가 발생함. 클로저 메서드는 반환이 불가?, doSomething() 메서드는 문자열을 반환해야함. 

</br></br>

```swift
func doSomething(completion: @escaping (_ value: String) -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        completion("new String")
    }
}

func doSomethingInTheFuture() -> Future<String, Error> {
    Future { promise in
        self.doSomething { value in
            promise(.success(value))
        }
    }
}
```

이렇게 Future를 사용하여 해결가능. 

</br></br>


언제쓸까? combine이 아닌 @escaping 클로져로 구현되어 있는 기존의 코드, 서드파티 라이브러리를 사용할 때 combine과 결합하여 사용하기 위해 쓰지 않을까.. 







### Promise ? 

<p align="center">
  <img width="1197" alt="스크린샷 2024-05-14 오후 6 17 01" src="https://github.com/jaehoon9186/study/assets/83233720/8e0a9ec2-5a79-46c3-b6d1-6772a59cb171">
</p>

프로미스는 클로져이고,  반환할 엘리먼트나 에러를 포함하는 result 타입을 인풋으로. 



