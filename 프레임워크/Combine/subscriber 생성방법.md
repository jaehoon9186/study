# subscriber 생성방법

```Subscriber``` 프로토콜을 채택해 subscriber를 직접 만들어 줄수 있지만.   

combine은 더욱 쉽게 만들수 있는 방법을 제공해 줍니다.  

1. [sink(receiveCompletion:receiveValue:), documentation](https://developer.apple.com/documentation/combine/publisher/sink(receivecompletion:receivevalue:))
2. [assign(to:on:)](https://developer.apple.com/documentation/combine/publisher/assign(to:on:))
3. [assign(to:)](https://developer.apple.com/documentation/combine/publisher/assign(to:))


# sink(receiveCompletion:receiveValue:)
<img width="1042" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/53deea68-f763-4d62-99f6-589d09037a48">


publisher의 인스턴스 메소드로 sink를 사용하여 subscription을 생성해 줄 수 있습니다. 

```swift
let publisher: Publishers.Sequence<[String], Never> = ["사과", "바나나", "포도", "", "귤"].publisher

struct FruitError: Error {}

func throwFruitBlank(fruitName: String) throws -> String {
    if fruitName.count > 0 {
        return fruitName
    } else {
        throw FruitError()
    }
}

let subscriber = publisher
    .tryMap({ item in
        return try throwFruitBlank(fruitName: item)
    })
    .sink { completion in
    switch completion {
    case .finished:
        print("completion Finished")
    case .failure(let err):
        print("completion Failure: \(err.localizedDescription)")
    }
} receiveValue: { item in
    print(item)
}
```

sink 메소드에서 completion은 .finished, .failure 두가지 경우로 구분지을 수 있습니다. 

<img width="1051" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/21a5cac9-bb39-4b2c-8b82-6542f37025d1">

```sink(receiveValue:)``` Failure가 Never인경우 value만 받을 수 있는 메소드도 있습니다. 


# assign(to:on:)

<img width="1086" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/2487922e-da89-4e76-a945-33a048f7bfb2">

```swift
class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)", terminator: "; ")
        }
    }
}


var myObject = MyClass()
let myRange = (0...2)
cancellable = myRange.publisher
    .assign(to: \.anInt, on: myObject)


// Prints: "anInt was set to: 0; anInt was set to: 1; anInt was set to: 2"
```
Documentation에 있는 예 입니다.  

적용할 대상 오브젝트, 적용할 프로퍼티의 키패스에 각 엘리먼트를 할당합니다. sink()보다 깔끔. 

<img width="965" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/d794174b-44de-4cd7-8a5f-f36ab952f7e9">

documentation에서 볼 수 있듯이 assign은 strong 참조를 하기 때문에 주의가 필요합니다. sink로 weak self !. 


# assign(to:)

<img width="1023" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/0d79138f-e066-406d-a6c7-052fca0fbe48">

to: ```@Published```로 표기된 속성에 적용 가능합니다.  

assign(to:)메서드는 subscription 라이프 사이클을 관리하기때문에 업스트립의 퍼블리셔가 deinit되면 자동을 cancel 됩니다. 따라서 assign(to:on:)과 달리 AnyCancellable을 반환하지 않습니다. 

```swift
class MyModel: ObservableObject {
    @Published var lastUpdated: Date = Date()
    init() {
         Timer.publish(every: 1.0, on: .main, in: .common)
             .autoconnect()
             .assign(to: &$lastUpdated)
    }
}
```
도큐먼트에 있는 예제.  

assign(to:)메서드에는 inout 키워드가 있어 ```&``` 사인을 사용하고, @Published 로 선언된 프로퍼티에 할당하기 위해 ```$``` 사인을 사용합니다. 






