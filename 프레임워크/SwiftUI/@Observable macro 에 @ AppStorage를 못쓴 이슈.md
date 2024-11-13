# @Observable macro 에 @AppStorage를 못쓰는 이슈

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

# 다른 방식으로 
- [https://fatbobman.com/en/posts/userdefaults-and-observation/](https://fatbobman.com/en/posts/userdefaults-and-observation/)

그냥 @AppStorage를 사용안하고 유저디폴트를 사용하는 방식이 더 깔끔한듯. 

```swift

@Observable
class SortSettings {
    @ObservationIgnored
    var sortOrder: SortOrder {
        get {
            access(keyPath: \.sortOrder)
            guard let rawValue = UserDefaults.standard.string(forKey: "sortOrder"),
                  let sortOrder = SortOrder(rawValue: rawValue) else {
                return _sortOrder
            }
            return sortOrder
        }
        set {
            withMutation(keyPath: \.sortOrder) {
                UserDefaults.standard.set(newValue.rawValue, forKey: "sortOrder")
            }
        }
    }


    @ObservationIgnored
    var sortType: SortType {
        get {
            access(keyPath: \.sortType)
            guard let rawValue = UserDefaults.standard.string(forKey: "sortType"),
                  let sortType = SortType(rawValue: rawValue) else {
                return _sortType
            }
            return sortType
        }
        set {
            withMutation(keyPath: \.sortType) {
                UserDefaults.standard.set(newValue.rawValue, forKey: "sortType")
            }
        }
    }

    // default
    @ObservationIgnored
    private let _sortOrder: SortOrder = .descending
    @ObservationIgnored
    private let _sortType: SortType = .lastUsedDate
}
```
