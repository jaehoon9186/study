# WWDC 2019 Introducting Combine

[WWDC 영상](https://developer.apple.com/videos/play/wwdc2019/722)  

컴파인 공부를 위함. 

<img width="1242" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/090b3cc8-8498-4400-a7cd-04907e56fdf6">


비동기프로그래밍에 대해 이야기하면서 예시로 앱 하나를 소개한다.   
학생들이 마법학교에 등록할 수 있도록 하는 앱임.  
요구사항으로
* 유효한 사용자 이름, 서버에 네트워크 요청을 하여 확인할
* 패스워드 매칭, 로컬로 일치여부 확인
* 사용자 인터페이스 유지, 위의 작업을 수행하는 동안 메인스레드를 차단하지 않고 응답하는

이러한 앱이 어떻게 작동하는지 보자. 
<img width="927" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/1e5fce15-dd5d-4b48-ae81-b913882b0c15">


Taget/Action을 통해 사용자 입력에 대한 알림을 수신한다. Timer를 사용하여 사용자가 타이핑을 잠시 멈출 때 까지 기다리므로 네트워크 요청으로 서버에 과부화(overwhelm)를 주지 않도록 한다. 
마지막으로 KVO와 같은 것을 사용하여 비동기 작업에 대한 진행률 업데이트를 수신한다.  

이러한 요청에 따라 UI를 업데이트 해야한다. 
![image](https://github.com/jaehoon9186/study/assets/83233720/84c125fe-922e-4857-9f4d-029070f0f371)
그러나 여기서는 더 많은 비동기 작업을 수행했다. URLSession 요청에 대한 응답을 기다려야 했고, 그 결과를 병합하여 검사해야했고, 모든 작업이 완료되면 KVC와 같은 것을 사용하여 UI를 업데이트 해야했다. 

<img width="1107" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/6cde09a6-a354-44c4-9476-afa2232cb3f2">

Cocoa SDK 에서는 많은 비동기 인터페이스를 찾을수 있다. 이 모든것들은 중요하고 다른 사용법을 가지고 있다. 
그러나 이러한 것들을 함께 구성해야 할 때 약간 어려울 수 있다. 그래서 Combine에서 이것들을 대체하는 것이 아니라 공통점을 찾기 시작했다. 

<img width="1273" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/28ab1a38-d5ef-4b0a-a0de-7cda86ab53d2">

Combine은 시간이 지남에 따라 값을 처리하기 위한 통합적인 선언적 API이다. 

# Combine Features
<img width="1010" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/fedc6df7-2e0b-4298-bf95-44c8daeb9020">

* Generic과 같은 Swift기능을 사용할 수 있음. Combine은 Swift로 작성되었기 때문. Generic을 사용하면 코드양을 줄일 수 있음. 비동기 동작에 대한 알고리즘을 한번 작성하고 모든 종류의 다양한 비동기 인터페이스에 적용할 수 있음을 의미한다.
* Type Safe하다. 런타임이 아닌 컴파일 시간에 오류를 찾을 수 있다. 
* Composition first, 주요 디자인 포인트로 구성이 먼저?. 핵심기능은 간단. 여러개를 구성하고 조합하여 더 많은 것을 만들수 있음?
* Request driven, 컴파인은 요청기반이다. 앱의 메모리 사용량과 성능을 신중하게 관리할 수 있다.


# Key Concepts 컴파인의 핵심 개념
<img width="1033" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/680d92e1-df51-409e-a6fc-dc1292126fa3">

## Publisher
<img width="1231" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/a35f2335-a1d7-4c79-b828-1fcd43e7c261">

* Publisher는 Combine API의 선언적 부분이다. values와 errors가 생성되는 방식을 설명함.
반드시 뭔가를 생산하는 것은 아니다. (생산할 수도? 아닐수도?)
* 값타입이다. struct 구조체를 사용함. 
* subscriber(구독자)등록도 허용한다.

<img width="1312" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/897cb51a-5a01-4125-a3ef-3d19166ec7e6">

* 두가지의 associatedtype이 있음
  * Output : 생성되는 값의 종류
  * Failure : 생성되는 Error의 종류, Publisher가 Error를 생성할 수 없는 경우 Never type을 사용할수 있음.
* 핵심 기능
  * ```func subscribe```  
   : 제약 조건에서 알 수 있듯이 subscriber의 입력이 publisher의 출력과 일치하고 subscriber의 실패가 publisher의 실패와 일치해야 한다.
  

Publisher에 대한 예를 알아보자. 
<img width="1307" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/86506b43-8624-4b94-ab01-5757a60c906e">
NotificationCenter의 새로운 Publisher임. 보다시피 구조체이고, output type이 Notification이고 Failure type은 Never이다.  
Center, name, object로 생성되는 것도 알수 있다. 기존 NotificationCenter API에 익숙하다면 친숙해 보일것, 컴바인은 기존의 API를 대체 하는 것이 아닌 적응 시키는 것.  


## Subscriber
<img width="1256" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/8df1a712-7e58-490e-b6c2-ba1d016396a2">

* subscriber는 publisher의 반대되는 개념이다. Publisher가 유한한 경우 completion을 포함한 값들을 받는다.
* reference type이다. subscriber는 값을 받으면 행동하고 상태를 변경하기때문에 참조 타입임. class와 동일.

<img width="1308" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/cf16de2a-1357-461c-96a3-905d576910b4">

* 두가지의 associatedtype
  * Input
  * Failure : failure를 수신할 수 없는 경우 Never type을 사용할 수 있음. 
* 핵심기능 세가지 (func receive)
  * ```subscription```  
   : 
  * sdfsf






