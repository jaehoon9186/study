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
### 관찰할 대상에 해야할 것.

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
### 관찰자(Observer) 만들기. 

* Observer 클래스의 인스턴스는 하나 또는 그이상의 프로퍼티의 변경에 대한 정보를 관리함.
* Observer를 만들땐 ```observe(_:options:changeHandler:)``` method를 사용해라.
    * 관찰할 프로퍼티에 대한 key path 필요.
    * > <img width="599" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/0f646419-8416-44e0-9867-976a3604849e">   
      > 이거 도큐먼트를 못찾겠음..



```swift
class MyObserver: NSObject {
    @objc var objectToObserve: MyObjectToObserve
    var observation: NSKeyValueObservation?


    init(object: MyObjectToObserve) {
        objectToObserve = object
        super.init()


        observation = observe(
            \.objectToObserve.myDate,
            options: [.old, .new]
        ) { object, change in
            print("myDate changed from: \(change.oldValue!), updated to: \(change.newValue!)")
        }
    }
}
```

* key path로 옵져브할 프로퍼티를 지정해준걸 볼수 있음.
* [NSKeyValueObservedChange](https://developer.apple.com/documentation/foundation/nskeyvalueobservedchange) 인스턴스의 oldValue, newValue 프로퍼티를 사용함으로 변경된 값들을 볼수 있다.
* 만약 변경된 값를 볼 필요가 없다면. observe() 메소드에 options를 안주면됨. 그러면 oldValue, newValue 등은 nil이 리턴.

# Associate the Observer with the Property to Observe
### Observer와 관찰할 프로퍼티와 연결

* 도큐먼트의 예제에서는 초기화 할때 매개변수로 전달하여 연결함.

```swift
let observed = MyObjectToObserve()
let observer = MyObserver(object: observed)
```


# Respond to a Property Change
### 프로퍼티 변경에따른 응답. 

* 위의 예제에서 변경이 이뤄졌을때의 응답을 확인해봄. 

```swift
observed.updateDate() // Triggers the observer's change handler.
// Prints "myDate changed from: 1970-01-01 00:00:00 +0000, updated to: 2038-01-19 03:14:08 +0000"
```

# 추가

## ```observe(_:options:changeHandler:)``` method의 옵션들이 궁금하다. 
[NSKeyValueObservingOptions](https://developer.apple.com/documentation/foundation/nskeyvalueobservingoptions) 


## Observer를 만들때 꼭 클래스를 정의하지 않아도 된다. 

```swift
let observed = MyObjectToObserve() // 관찰 대상이 있는 클래스. 

let observation: NSKeyValueObservation? 

observation = observed.observe(\.myDate, options: [.new, .old]) {
    print("\($0.myDate), \($1)")
}
```






