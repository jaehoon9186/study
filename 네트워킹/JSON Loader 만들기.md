# JSON Loader 만들기

### 참고
- [Mocking a Network Request (Unit Testing Part 3)
](https://www.youtube.com/watch?v=A627xU_94kE&list=LL&index=2)

```swift
protocol JSONLoadable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON(filename: String) -> Data
}

extension JSONLoadable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON(filename: String) -> Data {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON file.")
        }

        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            fatalError("Failed to decode the JSON.")
        }
    }
}
```

```swift

// 클래스에서 JSONLoadable 프로토콜 채택
class mockService: JSONLoadable 

// 사용
let data = loadJSON(filename: "WebSearchResponse")

```

extension으로 기본 구현된 메서드로 데이터를 반환하도록 하였음. 

일단 unit test를 위해 만들었으나, 실 프로젝트에 적용시에는 fatalError()로 중지되도록 하지 않고 에러 핸들링이 이뤄져야 할 것 같다. 
