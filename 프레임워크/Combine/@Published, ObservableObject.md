# @Published, ObservableObject


### 
* [Published docs](https://developer.apple.com/documentation/combine/published)
* [ObservableObject](https://developer.apple.com/documentation/combine/observableobject)

# @Published 

<img width="875" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c5dff981-c3e1-4d29-82fa-dc86027d6fe1">

@Published 키워드는 클래스내의 프로퍼티를 퍼블리셔처럼 사용가능하게 해줍니다. (class 만 가능함. struct 등 불가)  

값을 변경할 때는 일반 변수 처럼 사용가능하고, Publisher로서 사용될 때는 $ 키워드를 이용하면 됩니다.  

subject중 CurrentValueSubject와 비슷한 역할을 하는 것 같네요.  

주의해야할 점으로 다운스트림으로 퍼블리싱할때, willSet 블록에서 실행을 합니다. 따라서 예제에서 볼 수 있듯이 temperature의 실제 값은 변경이 안된 상황에서 퍼블리싱이 이뤄집니다. 


다른 퍼블리셔에서 @Published 퍼블리셔로 재 퍼블리싱(?)을 할때는 assign(to:)메소드를 사용합니다. 


```swift
class Weather {
    @Published var temperature: Double
    init(temperature: Double) {
        self.temperature = temperature
    }
}


let weather = Weather(temperature: 20)
let cancellable = weather.$temperature
    .sink() {
        print ("Temperature last: \(weather.temperature) , now: \($0)")
}
weather.temperature = 25


// Prints:
// Temperature last: 20.0 , now: 20.0
// Temperature last: 20.0 , now: 25.0
```


# ObservableObject

<img width="869" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/7102ce3c-7783-41e6-9f83-9dd20eed3461">

ObservableObject 프로토콜은 퍼블리셔(observableobjectpublisher)를 포함하고 있는데요. 이 친구는 클래스의 프로퍼티중 @Published 키워드가 달린 퍼블리셔를 관찰해서 걔네들이 변경되면 전에 다운스트림으로 방출합니다. 
(@Published 퍼블리셔가 변경 된 후 ㄴㄴ, 변경 직전에 ㅇㅇ)

도큐먼트의 예와 같이 ObservableObject 프로퍼티를 채택한 클래스는 objectWillChange 프로퍼티로 observableobjectpublisher 퍼블리셔에 접근 할 수 있고, (내부에선 self 로 접근하면 되것죠?)  

observableobjectpublisher는 퍼블리셔이기에 subscription을 생성할 수 있습니다.

send() 메서드로 다운스트림 subscriber에게 방출하는 하는 것도 가능합니다. 


```swift
class Contact: ObservableObject {
    @Published var name: String
    @Published var age: Int


    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }


    func haveBirthday() -> Int {
        age += 1
        return age
    }
}


let john = Contact(name: "John Appleseed", age: 24)
cancellable = john.objectWillChange
    .sink { _ in
        print("\(john.age) will change")
}
print(john.haveBirthday())
// Prints "24 will change"
// Prints "25"              <-- haveBirthday() -> Int
```

<img width="792" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c9f9bb34-0bdd-4921-868c-1acb3b8a5797">

objectWillChange는 [observableobjectpublisher](https://developer.apple.com/documentation/combine/observableobjectpublisher) 타입. 



# 결

@Published, ObservableObject 는 UIkit에서도 사용은 가능하지만. SwiftUI에서 보통 사용하는 것 같다.  UIKit에서 사용하려면 좀 번거로운 듯 하다. 
스유에서의 데이터 흐름이 어떻게 이뤄지는지 궁금한데 차차 알아보도록 하자. 
* [WWDC2019 Data Flow Through SwiftUI](https://developer.apple.com/videos/play/wwdc2019/226/)
* [WWDC2020 Data Essentials in SwiftUI](https://developer.apple.com/videos/play/wwdc2020/10040/)
* [Migrating from the Observable Object protocol to the Observable macro](https://developer.apple.com/documentation/swiftui/migrating-from-the-observable-object-protocol-to-the-observable-macro)

