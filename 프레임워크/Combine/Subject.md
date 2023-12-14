# Subject

### 
* [Subject docs](https://developer.apple.com/documentation/combine/subject)


# Subject ? 

![image](https://github.com/jaehoon9186/study/assets/83233720/8a8ae4e6-0044-4015-a8c8-467e988ad079)


프로토콜, 지속적으로 다운스트림으로 값을 전달할 수 있는 퍼블리셔 입니다.  

send() 메서드로 값 주입.  

프로토콜을 준수하는 클래스로는 두가지, CurrentValueSubject, PassthroughSubject가 있습니다. 

# CurrentValueSubject
<img width="892" alt="스크린샷 2023-12-14 오후 3 21 15" src="https://github.com/jaehoon9186/study/assets/83233720/43ab363b-7a1e-4a38-90bd-0f9ddcf49fde">

PassthroughSubject와 다르게 최근 값을 가지고 있습니다. 

# PassthroughSubject
<img width="862" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/15119eda-5124-45e8-aa7c-da6a21106764">

기존 값이 없음. 구독이후 값이 publish되었을때 구독자들에게 전달합니다. 

# 예제 
```swift
import Combine

class ViewModel {
    
    let fruits = CurrentValueSubject<[String], Never>(["사과"])
    let newFruitEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        newFruitEntered.sink { [weak self] fruit in
            self?.fruits.send((self?.fruits.value)! + [fruit])
        }.store(in: &subscriptions)

        fruits.sink { result in
            print("fruits updated : \(result)")
        }.store(in: &subscriptions)
    }
}

let viewModel = ViewModel()

viewModel.newFruitEntered.send("포도")
viewModel.newFruitEntered.send("딸기")
```
