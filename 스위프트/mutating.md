# mutating

[docs](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods/#Modifying-Value-Types-from-Within-Instance-Methods)  

구조체(structure)와 열거형(enumeration)은 값 타입(value type)이다. 
값 타입의 프로퍼티들은 기본적으로 인스턴스 메서드 내에서 수정할 수 없다.  

그러나, 수정하길 원한다면 메소드에 ```mutating```키워드를 사용해라! 
mutating method가 종료될 때 모든 변경사항이 원래의 구조체에 다시 기록된다. 

도큐먼트에서는 두가지의 경우로 설명해줌.
1. 멤버변수의 값을 변경 할 때
2. 새로운 인스턴스로 대체(replace) 할 때

### 1. 멤버 변수의 값을 변경 할 때
```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"
```
<br/>

⚠️ 구조체가 상수로 선언되어 있으면 멤버변수가 변수로 선언되어 있더라도 변경이 불가 하다. 참고 [Stored Properties of Constant Structure Instances:](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties#Stored-Properties-of-Constant-Structure-Instances)
```swift
let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error
```
<br/>

### 2. 새로운 인스턴스로 대체(replace) 할 때
```self```프로퍼티를 사용한다면 완전히 새로운 인스턴스를 할당할 수 있다.  
```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}
```
<br/>

열거형예제
```swift
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off
```
