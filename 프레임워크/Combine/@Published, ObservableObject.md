# @Published, ObservableObject


### 
* [Published docs](https://developer.apple.com/documentation/combine/published)
* [ObservableObject](https://developer.apple.com/documentation/combine/observableobject)

# @Published 

<img width="875" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c5dff981-c3e1-4d29-82fa-dc86027d6fe1">


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

@Published 키워드는 클래스내의 프로퍼티를 퍼블리셔처럼 사용가능하게 해줍니다. (class 만 가능함. struct 등 불가)  

값을 변경할 때는 일반 변수 처럼 사용가능하고, Publisher로서 사용될 때는 $ 키워드를 이용하면 됩니다.  

subject중 CurrentValueSubject와 비슷한 역할을 하는 것 같네요.  

주의해야할 점으로 다운스트림으로 퍼블리싱할때, willSet 블록에서 실행을 합니다. 따라서 예제에서 볼 수 있듯이 temperature의 실제 값은 변경이 안된 상황에서 퍼블리싱이 이뤄집니다. 


다른 퍼블리셔에서 @Published 퍼블리셔로 재할당(?)을 할때는 assign(to:)메소드를 사용합니다. 


# ObservableObject

<img width="869" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/7102ce3c-7783-41e6-9f83-9dd20eed3461">

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



