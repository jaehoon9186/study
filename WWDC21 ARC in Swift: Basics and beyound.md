# WWDC21 ARC in Swift: Basics and beyound
<img width="581" alt="스크린샷 2023-07-19 오후 6 11 03" src="https://github.com/jaehoon9186/study/assets/83233720/ee416e4d-ed84-465f-9db2-5d311b3288e1">

swift는 구조체 및 열거형과 같은 강력한 값 유형을 제공한다.  
참조 유형을 사용하였을 때의 의도치 않은 공유의 위험을 피하기 위해 가능하면 값 유형을 사용하는 것이 좋다.  
클래스는 swift의 참조유형(reference type)이며, 이를 사용하기로 결정하면 swift는 ARC(Automatic Reference Counting)를 통해 메모리를 관리한다.  

효과적인 swift를 작성하려면 ARC가 어떻게 작동하는지 이해하는 것이 중요하다.  


## Object lifetimes and ARC / 객체 수명과 ARC
swift에서 개체의 수명은 초기화에서 시작하여 마지막 사용에서 끝난다.  
ARC는 수명이 다한 후에 개체 할당을 해제하여 자동으로 메모리를 관리한다.  
ARC는 reference counts(참조횟수)를 추적하여 객체의 수명을 결정한다.  
ARC는 (retain and release 작업을 하는)Swift 컴파일러에 의해 구동된다. 
런타임시에 증가된 rc를 유지하고 해제하면 감소한다.  
rc가 0이되면 객체는 deallocated(할당 해제)된다.  

<img width="566" alt="스크린샷 2023-07-19 오후 6 35 42" src="https://github.com/jaehoon9186/study/assets/83233720/32f1a511-5ad8-4aa8-85fe-acad472c4715">   

: traveler2의 첫 Traveler 인스턴스 참조와 마지막 사용으로 Swift 컴파일러는 retain과 release를 삽입한다.  
(왜 인스턴스 생성후 처음 변수에 할당하는 곳(traveler1)에서는 retain이 없는거지?)  

<img width="504" alt="스크린샷 2023-07-19 오후 6 50 03" src="https://github.com/jaehoon9186/study/assets/83233720/a6886389-f7c3-4a41-ad8e-9aa1f0069972">

Object lifetimes는 사용기반이다.  
but, 마지막 사용 이후에 lifetime이 끝날 수도 있음.  

> 예시 이해를 돕기 위해 움짤로 만들어보았다.  
> ![gif1](https://github.com/jaehoon9186/study/assets/83233720/360a2497-e5cb-4df3-a5b7-8a2b92730795)

  


## Observable object lifetimes / 관찰 가능한 객체 수명
: 개체 수명을 관찰 가능하게 만드는 언어 기능, 관찰된 개체 수명에 의존하는 결과 및 이를 수정하는 몇 가지 안전한 기술들에 대해 설명  

대부분의 경우 잘 동작한다. 하지만 이것은 우연의 일치!. 
<img width="1516" alt="스크린샷 2023-07-20 오후 10 36 40" src="https://github.com/jaehoon9186/study/assets/83233720/1ebb5aef-d0e8-4820-a84b-f311b94fe945">  

버그가 오랜시간 숨겨져 있을수도있고, 컴파일러 업데이트, 소스코드 변경으로 인해 갑자기 등장 할수도 있다!  

그래서 observable object로 만들어야 한다!  
<img width="1190" alt="스크린샷 2023-07-20 오후 10 39 40" src="https://github.com/jaehoon9186/study/assets/83233720/aa963323-e29f-48c2-9777-d6042e895f21">
이를 위해 swift의 기능과, 이러한 기능을 사용하지 않았을 때(observed )의 결과와 안전한 기술들에 대해 알아보자. 

1) Language features
* ```Weak``` and ```unowned``` refernces 
  - do not paricipate in reference counting
  - break reference cycles  
    : weak, unwoned 키워드를 사용하여서 rc를 카운팅 하는데에 참여하지 않으며, 이로인해 reference cycle이 일어나지 않도록 한다!  
    : <img width="2312" alt="스크린샷 2023-07-20 오후 11 09 04" src="https://github.com/jaehoon9186/study/assets/83233720/be73b235-6f56-4185-9dbd-815bc3a97007">
    But, ```Weak```, ```unowned```키워드를 사용한다 하더라도 버그가 발생할수 있다. (참조순환은 없애줌)
    위 코드를 보면 test() func의 마지막줄을 실행하기전에 Traveler 인스턴스가 메모리에서 이미 해제 될수 있는 상황이기때문에 앱이 크러쉬난다. 옵셔널 바인딩이 이 문제를 해결할 수 있지만, 옵셔널 바인딩은 문제를 더 악화(worsens)시킨다.

* sdfsf
* 

2) Consequences and safe techniques


> reference cycle ? 참조 순환이 머임?
  
<img width="2419" alt="스크린샷 2023-07-20 오후 10 54 58" src="https://github.com/jaehoon9186/study/assets/83233720/db320028-0698-4e36-b8aa-8c1d3b717153">  
end-used 이후에서 서로 참조하고 있는 상황!! 개체의 할당이 취소 되지 않아 메모리 누수가 발생한다.  
