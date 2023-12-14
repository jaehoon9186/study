# Cancellable, cancel(), AnyCancellable.md

### docs
* [Cancellable](https://developer.apple.com/documentation/combine/cancellable)
* [cancel()](https://developer.apple.com/documentation/combine/cancellable/cancel())
* [AnyCancellable](https://developer.apple.com/documentation/combine/anycancellable)

### 읽어볼
* [What exactly is a Combine AnyCancellable?](https://www.donnywals.com/what-exactly-is-a-combine-anycancellable/)

# 왜 Cancel 해야하나?

Cancellable docs에 보면 cancel() 함으로 할당된 자원을 해제하고, 이는 타이머, 네트워크 엑세스, 디스크 I/O에서 발생할수 있는 사이드 이펙트를 멈출수 있다고 합니다. 


# AnyCancellable, cancel(), store(in:)

```swift
class ViewModel {
    let subject = CurrentValueSubject<Int, Never>(1)
    var cancellableBag = Set<AnyCancellable>()

    init() { bind() }
    deinit { print("deinit") }

    func bind() {
        let subscription = subject.sink { value in
            print(value)
        }
                                           // 1.
//            .cancel()                    // 2.
//            .store(in: &cancellableBag)    // 3.

        subject.send(2)
    }
}

var vm: ViewModel? = ViewModel()
vm?.subject.send(3)
vm = nil
```

출력될 결과를 예상해 보겠습니다. 
1. cancel(), store(in:) 메소드 둘다 호출 안함.
2. cancel() 메소드만 호출
3. store(in: ) 메소드만 호출


1번의 경우 출력 결과는 ```1\n 2\n deinit```입니다. subscription의 타입은 AnyCancellable 입니다. AnyCancellable의 문서를 보면 메모리에서 deinit될때 cancel()을 실행한다고 합니다. 
따라서 bine() 스코프가 마치는 부분까지 유지하고 해제 됩니다.   

2번의 경우 ```1\n deinit```을 출력합니다. 바로 cancel해서 subscription이 해제된 상황입니다.  

3번의 경우 ```1\n 2\n 3\n deinit```을 출력합니다. cancellableBag에 저장함으로서 메모리에서 해제되지 않고 구독을 유지할 수 있습니다. 메모리에서 ViewModel() 인스턴스가 해제됨과 동시에 멤버변수인 cancellables도 해제, 관련된 AnyCancellable 들도 해제가 됩니다. 


// 파일 다운로드 같은 경우 상위레이어에 저장해서 라이프사이클을 관리 하는것일까?
