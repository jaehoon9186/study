# 제네릭 swift case 문으로 구분하기

```swift
func doSomething<T>(type: T.Type) {
    switch type {
    case is String.Type:
        print("It's a String")
    case is Int.Type:
        print("It's an Int")
    default:
        print("Wot?")
    }
}
```
