# @Observable macro 에 @AppStorage를 못쓴 이슈

- [https://stackoverflow.com/questions/76606977/swift-ist-there-any-way-using-appstorage-with-observable](https://stackoverflow.com/questions/76606977/swift-ist-there-any-way-using-appstorage-with-observable)


현재 iOS 17 의 앱을 개발중인데. 

@Observable macro를 적용하는 클래스내에서 @AppStorage 를 사용불가한것같다. 

UserDefault를 사용하거나, get set을 사용해 조치하는듯함. 왜이렇게 해놨지.

```swift
@Observable
class ColorThemeManager {
    @ObservationIgnored
    @AppStorage("name") private var storedName = "" {
        didSet {
            name = storedName
        }
    }

    var name: String {
        didSet {
            // print("관찰을 위함. didSet name")
        }
    }

    init() {
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
    }

    func setName(newName: String) {
        storedName = newName
    }
}
```

링크인 스택오버플로우에는 없었지만..   
이런식으로 한번 구현해봄.   

저장을 위한 @AppStorage 변수와, 옵저빙을 위한 변수를 구분해 구현함.  

