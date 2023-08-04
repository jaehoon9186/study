# KVO

[docs](https://developer.apple.com/documentation/swift/using-key-value-observing-in-swift#Define-an-Observer)

도큐먼트를 보며 KVO에 대해 이해해 보자~~

<img width="828" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/e0197d94-ebf7-48fe-b0f0-967a80b6498f">

Cocoa design Pattern 중 하나임


<img width="1034" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/62ad9d29-29af-4ed2-90ce-e74761d4609a">

KVO를 이용함으로  
객체에 알림~ 뭐를? 다른 객체의 프로퍼티에 변경사항을 ~  

# Overview

* KVO는 Key-value observing의 약자임.
* 객체에다가 변경사항(다른 객체의 프로퍼티 변경사항)을 알리기 위해 사용하는 Cocoa programming 패턴임.
* Model과 View 사이와 같은, 논리적으로 분리된 곳에서 변경사항을 소통할때 유용함.
* ```NSObject``` 를 상속받은 클래스에서만 사용가능.


# Annotate a Property for Key-Value Observing

```swift
class MyObjectToObserve: NSObject {
    @objc dynamic var myDate = NSDate(timeIntervalSince1970: 0) // 1970
    func updateDate() {
        myDate = myDate.addingTimeInterval(Double(2 << 30)) // Adds about 68 years.
    }
}
```
* 관찰할 프로퍼티에 ```@objc``` attribute와, ```dynamic``` modifier를 추가해라.
* 클래스는 ```NSObject``` 상속받음. 

# Define an Observer













