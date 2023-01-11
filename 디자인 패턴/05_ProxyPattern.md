# 프록시 패턴 Proxy Pattern 
Proxy 는 대리 라는 뜻  

Proxy 역할과 RealSubject 역할로 나뉨 

RealSubject. 
: 실제 처리할 일을 정의

Proxy. 
: 캐싱을 구현하여 요청을 중간에서 컨트롤 가능  
클라이언트의 권한에 따라 제어도 가능  


예제)  
프록시 서버  
웹서버의 부담을 줄여주기 위하여 자신이 웹서버 대신 할 수 있는 일을 최대한 처리한 다음 할수 없는 일을 웹서버에게 넘기게 됩니다.  


### 장점 / 단점 
장점  
: realSubject가 메모리가 큰 인스턴스 일 경우 해당 인스턴스를 생성하는 시점을 정말로 필요한 시점에 지연시킬 수 있습니다.  
Proxy는 realSubject가 준비되지 않았거나, 사용할 수 없는 경우에도 동작 합니다.  
개방 폐쇄 원칙을 지켜 RealSubject나, 클라이언트를 변경하지 않고, 새로운 프록시를 도입할 수 있습니다.  

단점  
: Proxy 클래스를 도입해야 함으로 코드가 복잡해 집니다.  
RealSubject의 응답이 지연될 수 있습니다.  



## swift로 프록시 패턴 만들어보기

```swift
import UIKit

// Proxy Pattern

/*
 지우가 포켓몬을 소환한다.

 몬스터 볼에서 포켓몬이 나오기 까지 높은 비용이 발생한다.
 몬스터 볼 내부에서 데이터를 가지고 와서 밖으로 출력하기 까지

 몰스터 볼이 오픈되고 빛이 나는 순간까지
 몬스터볼은 프록시(대리자)로서 데이터처리를 진행한다.
 */


protocol 포켓몬소환Subject {
    func 포켓몬소환()
}

final class RealSubject: 포켓몬소환Subject {
    func 포켓몬소환() {
        print("나와라 포켓몬!!")
    }
}

final class Proxy: 포켓몬소환Subject {
    private lazy var realSubject = RealSubject()

    func 포켓몬소환() {
        print("펑 !")
        realSubject.포켓몬소환()
    }
}


Proxy().포켓몬소환()
/*
 펑 !
 나와라 포켓몬!!
 */
```



## 참조

[면접을 위한 CS 전공지식 노트 주홍철 저](https://github.com/gyoogle/tech-interview-for-developer)  
[야곰닷넷 디자인패턴](https://yagom.net/courses/design-pattern-in-swift/)
