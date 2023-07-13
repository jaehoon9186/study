# KeyPath

스유 리스트에 id값을 넣을때 ```\.self``` 로 넣어주는 예제를 보고 KeyPath를 알게 되었다.  
왜 키패스를 사용하는지 키패스는 무엇인지 알아보자.

[Docs](https://developer.apple.com/documentation/swift/keypath)  
[key-path expressions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Key-Path-Expression)  


## keyPath ?
<img width="654" alt="스크린샷 2023-07-12 오후 6 17 03" src="https://github.com/jaehoon9186/study/assets/83233720/df99adb9-9233-4c10-bfaa-7e691c58db34">  
  
특정 루트타입에서 특정 결과값 타입으로의 키 경로.  
프로퍼티에 대한 경로가 저장되는 클래스인것 같다. (프로퍼티에 대한 참조)  
<br/>

## 값에 대한 참조? 프로퍼티에 대한 참조?
```swift
struct Person {
    let name: String
    let age: Int
}

let 철수 = Person(name: "철수", age: 26)

// 값에 대한 참조
print(철수.age) // 26

// 프로퍼티에 대한 참조
print(철수[keyPath: \Person.age]) // 26
// == \.age
// == \.self.age
```
간단한 예재. 일반적으로 인스턴스의 값을 가져올땐 ```철수.age``` 형식으로 가져왔다.  
이것이 값을 참조하는 방법이고. 
  
프로퍼티를 참조하는 방식으로는 keypath 를 이용하는 방법과 KVC(Key-Value Coding)이 있다. 
<br/>

## 왜? 이점?
[참고](https://dongminyoon.tistory.com/69)  
> 우선 잘 알려진 장점으로는 프로퍼티에 간접적으로 접근하고 있고 해당 key의 값이 런타임 중에 결정되기 때문에, 각 객체의 의존도는 낮출 수 있다는 장점이 있습니다.

값을 참조하는 것이 아니라 프로퍼티에 대한 경로(?)를 참고하는 것이기 때문에 다양한 응용이 가능할 것 같다.  
Expression에서도 다양한 방법에 대한 소개가 있다.  

또한 keypath는 프로퍼티와 서브스크립트에 대한 참조를 나타내는 타입이기때문에 변수에 저장되거나 전달 할 수 있다.   
```swift
let pathToAge = \Person.age
print(철수[keyPath: pathToAge])
```

<br/>

## 형식은?
```\<#클래스#>.<#프로퍼티#>```  
역슬레시(\)와 점(.)으로 표현. 

애플 문서에서는 root type이라고 하는데.. class, struct를 말하는것 같다.  
root type이 뭐지?? 
<br/>

## 종류

* AnyKeyPath
* PartialKeyPath<Root>
* KeyPath<Root, Value>
* WritableKeyPath<Root, Value>
* ReferenceWritableKeyPath<Root, Value>


<img width="528" alt="스크린샷 2023-07-13 오후 2 40 19" src="https://github.com/jaehoon9186/study/assets/83233720/7b7fd2ee-a11b-4db3-9a36-2f9adf5ede16">
<img width="517" alt="스크린샷 2023-07-13 오후 2 40 34" src="https://github.com/jaehoon9186/study/assets/83233720/022289ab-1ce2-4a4f-81f0-70a454b09fe9">
<img width="514" alt="스크린샷 2023-07-13 오후 2 42 06" src="https://github.com/jaehoon9186/study/assets/83233720/58e59588-6b80-4666-91bb-fe58e916bc88">


