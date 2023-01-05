# 싱글톤 패턴 Singleton Pattern

하나의 클래스에 오직 하나의 인스턴스를 가지는 패턴  

장점 : 하나의 인스턴스를 만들어 놓고 해당 인스턴스를 다른 모듈들이 공유하며 사용하기 때문에 인스턴스를 생성할때 드는 비용이 줄어든다.  
단점 : 의존성이 높아진다.  


## swift로 싱글톤 만들어보기
```swift
import UIKit

class singleton {
    // 1
    static let shared = singleton()
    // 2
    private init() { }
}
/*
 1. 유일한 객체가 될 프로퍼티를 static으로 정의 후 자기 자신을 할당한다.
    이름은 보통 shared, common, defaults, basic 등의 이름을 자주 사용
 2. 초기화 메서드의 접근 제한을 설정하여 외부에서는 초기화가 불가능하도록 설정
 */

let a = singleton.shared
let b = singleton.shared

print("a 주소 : ", Unmanaged.passUnretained(a).toOpaque())
print("b 주소 : ", Unmanaged.passUnretained(b).toOpaque())
/*
 a 주소 :  0x0000600003bb8190
 b 주소 :  0x0000600003bb8190
 */

```


## 싱글톤 패턴의 단점
TDD(Test Driven Development)를 할 때 걸림돌이 된다. TDD는 주로 단위 테스트를 하는데 싱글톤은 하나의 인스턴스를 기반으로 구현되어 있어 독립적인 인스턴스를 만들기 어렵기 때문


## 의존성 주입 
싱글톤은 사용하기가 쉽고 굉장히 실용적이지만 모듈 간의 결함을 강하게 만들 수 있다는 단점이 있다. 
이때 의존성 주입(DI, Dependency Injection)을 통해 모듈 간의 결합을 조금 더 느슨하게 만들어 해결할 수 있다.  
[의존성]()  





## 참조

[면접을 위한 CS 전공지식 노트 주홍철 저](https://github.com/gyoogle/tech-interview-for-developer)  
[야곰닷넷 디자인패턴](https://yagom.net/courses/design-pattern-in-swift/)
