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
 
> Stack, Heap, reference count

<img width="504" alt="스크린샷 2023-07-19 오후 6 50 03" src="https://github.com/jaehoon9186/study/assets/83233720/a6886389-f7c3-4a41-ad8e-9aa1f0069972">

Object lifetimes는 사용기반이다. 



## Observable object lifetimes / 관찰 가능한 객체 수명
: 개체 수명을 관찰 가능하게 만드는 언어 기능, 관찰된 개체 수명에 의조ㅓㄴ하는 결과 및 이를 수정하는 몇 가지 안전한 기술들에 대해 설명  

