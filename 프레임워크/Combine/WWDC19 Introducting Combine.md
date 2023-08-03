# WWDC 2019 Introducting Combine

[WWDC 영상](https://developer.apple.com/videos/play/wwdc2019/722)  

컴바인 공부를 위함. 

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
* Subscriber(구독자)등록도 허용한다.

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

* Subscriber는 Publisher의 반대되는 개념이다. Publisher가 유한한 경우 completion을 포함한 값들을 받는다.
* reference type이다. Subscriber는 값을 받으면 행동하고 상태를 변경하기때문에 참조 타입임. class와 동일.

<img width="1308" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/cf16de2a-1357-461c-96a3-905d576910b4">

* 두가지의 associatedtype
  * Input
  * Failure : failure를 수신할 수 없는 경우 Never type을 사용할 수 있음. 
* 핵심기능 세가지 (func receive)
  * ```subscription```  
   : Publisher 에서 subscriber로의 데이터 흐름을 제어 하는 방법. 
  * ```input```  
   : 입력을 받을수도 있다.  (upstream에서 전달 되는 값?)
  * ```complition```  
   : 연결된 Publisher가 유한한 경우 완료 또는 실패가 될 수 있는 complition을 받을 수 있음. 


subscriber 예제 
<img width="1312" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/bb53cf25-5e31-4a70-8f10-95f039411048">

Assign은 클래스이다. Assign은 input을 받으면 해당 객체의 프로퍼티에 기록하는 클래스임.  
Swift에서는 프로퍼티 값을 작성하는 경우 오류를 처리할 방법이 없음. 그래서 Failure를 Never로 설정해준 예제. 

# The Pattern 
어떻게 publisher와 subscriber가 함께 동작하는지 알아보자. 

<img width="1244" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/37bc303f-e560-4617-95c5-22e174ad26e9">

* Subscriber를 가지고 있는 Controller 또는 other type이 있음. 이러한 Controller들은 Subscribe()함수를 호출해서 Publisher에 연결해줘야 함.  
~~Controller는 subscriber를 Publisher에 붇여야 하는 책임이 있다. subscribe() 함수를 사용해서.~~


<img width="1276" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c46187b1-f9c8-4247-be9f-13bbee5f3437">

* 연결된 시점에서 Publisher는 Subscriber에게 subscription(구독권)을 보냄.
* subscription으로 subscriber는 몇 번 또는 무제한 요청을 할수 있게 됨. 

<img width="1270" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/30eff63b-f2f0-49a1-a8de-cef52e6d4030">

* 이제 Publisher는 subscriber에게 해당 개수 또는 이하의 값을 자유롭게 보낼수 있음.
* 만약 Publisher가 유한한 경우 Complition 또는 Error를 보냄.


#### 정리하면, one subscription, zero or more values, single completion. 

<img width="1306" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5699ef8a-f51f-4632-bcc4-61d9dfb836c2">

초반의 마법학교 등록 앱으로 돌아옴.  

Wizard 라는 모델 객체가 있음. 이번 예제 에서는 학년만을 가지고 설명함.  

* merlin은 현재 5학년이다.
* 나는 학생들이 졸업을 한다면 알림을 듣고 내 모델 객체의 값을 업데이트 하고 싶음.  
 그래서, NotificationCenter의 Publisher를 이용해 졸업 알림을 함.  
* Assign Subscriber를 만들고 merlin의 학년 속성을 새로운 값으로 할수 있도록 함.
* 다음으로 Publisher의 subscribe() 함수로 연결.

however, 컴파일되지 않는다. 이유는 type이 일치 하지 않기 때문. 

<img width="1183" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/bf5eb6fb-db11-4768-bd39-20c00270fbda">

NotificationCenter는 Notification을 만들어 보내는데, Assign는 학년의 type인 Int를 변경하려고 하는데 엉뚱한게 들어오니 에러남.  
그래서 필요한게 Notification과 Integer 사이의 무언가가 필요함. 그거슨 바로 Operator.

# Operator 

<img width="1213" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b84dca8f-eb74-4614-a090-714a6559eedf">

* Operator는 Publisher이다. Publisher 프로토콜을 채택할때 까지  
 ( 채택하면 Operator? )
* 또한 선언적이므로 value type 값타입.
* 뭘하냐? 값 변경, 값 추가, 값 제거 또는 다양한 종류의 동작들을 (describe) 함.
* upstream 으로 다른 Publisher를 subscribe함.
* downstream 으로 그 결과를 Subscriber에게 보냄.

예시 Map
<img width="1308" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/beccf9a2-ce08-46cb-910e-24ad20d4bd9d">

Map은 Upsteam과 연결하고(?) Upstream's output을 자체 output으로 변경하는 구조체임.  
Map은 자체적으로 Failure를 생성하지 않기 때문에 단순히 upstream's Failure를 그냥 미러링 하고 통과시킨다. 

<img width="1273" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/00bda896-c653-4264-b44b-a10bd78e2f05">

따라서 Map에는 Notification과 Integer 사이 변환하는 데 필요한 도구가 있다.  

어떻게 하는지 보자.  

<img width="1275" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/bffcbbb4-3c6d-459c-9af2-b468800fd1d5">

Publisher 와 Subscriber는 동일함. 여기에 컨버터가 추가됨. 컨버터는 graduationPublisher와 연결되도록 구성되어있고, 클로저를 가지고있음. 클로저는 notification을 받고 "NewGrade"라는 user info를 찾음. 그리고 정수형이면 리턴함. 아니면 0을 리턴. 이것이 의미하는건 클로저의 결과는 항상 integer이므로 Subscriber에 연결 할수 있다는 것임.  

따라서 모두 연결되고 컴파일되고 작동함. ㅇㅇ  

약간 장황함. 더 간결하게 사용도 가능하다. 

<img width="1249" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/88327c4d-486d-4c02-a4d5-59eb6a949529">

Poblisher protocol의 extension 임, 이제 모든 Publisher가 사용 가능함.  
( 각 연산자의 이름을 딴 기능을 추가했다. ? 이미 있다는건가? )  
보다시피 해당 arguments는 upstream을 제외하고 Map을 초기화 하는데 필요한 모든 것이다. 그 이유는 Publisher의 extension으로 단순히 self를 사용할 수 있기 때문.  
이게 사소한 편리함 처럼 보일수 있지만 이렇게 함으로 비동기 프로그래밍에 대한 생각을 변화시킬것. (대충 도움되는 뜻)  

<img width="1238" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/8b1c7b9a-da53-43a2-a0c1-69f38a705f0b">

extension에 작성한 구문을 적용해 보면 위와 같음. 
* Notification Publisher를 생성하고
* notification을 받으면 이전에 본것과 같은 클로저를 이용해 map 연산 한다음
* assign 할당 한다.  
이 구문이 매우 선형적이고 이해하기 쉬운 흐름으로 보임.  
Assign은 cancelable 을 반환함. combine에는 cancelation(취소)기능도 내장되어 있다. Cancelation 사용하면 필요한 경우 Publisher와 Subscriber를 조기에 해체할 수도 있음. 

이러한 단계별 구문은 Combine을 사용하는 방법의 핵심임.  
각 단계는 체인의 다음 명령어 세트를 설명한다. 
첫번째 Publisher에서 일련의 연산자들을 거쳐 Subscriber로 반환. 

이러한 Operator들을 많이 가지고있음. 바로 

# Declarative Operator API

<img width="1212" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b6998e5b-56bc-4d34-af86-f309dbe02522">

* Map, Filter, Reduce와 같은 ```functional transformation``` 들
* ```List operations```, 첫 번째, 두 번째 또는 다섯 번째 요소를 가져오는 것과 같응
* ```Error handling```, error를 기본값 또는 placement value로 바꾸는 것곽 같은.
* ```Thread or queue movement```, 무거운 처리작업을 백그라운드 스레드로 옮기거나 Ui 작업을 메인스레드에서 하거나
* ```Scheduling and time```, 예를 들어, integration with from loop, dispatch queue, support for timer, timeouts 등등.

<img width="1288" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/2a574c04-56f7-4052-acbc-93ed3ffc7550">

이러한 연산자가 너무 많아서 연산자를 탐색하는 방법에 대해 생각하는 것이 약간 어려울 수 있다. 
그래서 Combine에 대한 핵심 디자인 원식으로 돌아가는 것을 권장함. 바로 composition이다. 


# Try composition first
<img width="1290" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b313e5c0-bfd2-4bfd-b712-8902507fb067">

많은 작업을 수행하는 몇가지 Operator 들을 제공하는것 대신에, 각각 조금씩만(핵심만?) 수행하는 많은 연산자를 제공함. 이로서 더욱 이해하기 쉬워짐.  
따라서, 이러한 Operator 들을 탐색할 수 있도록 기존 Swift Collection API에서 해당 이름에 대해 영감을 얻음. 

<img width="955" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/8e14a2c7-e49d-49ae-88d5-bd2c155789a7">

위는 단일값, 아래는 많은 값, 왼쪽은 동기, 오른쪽은 비동기~   

swift에서는 정수를 동기식으로 표현해야하는 경우 Int와 같은것을 사용할 수 있음. 많은 정수를 표현해야 할 때는 array of integer 배열 사용함.  

Combine에서는 이러한 개념을 가져와 비동기 세계에 매핑했다.  
단일 값을 비동기로 나타낼때는 Future, 많은 값들을 비동기적으로 나타내야할 때는 Publisher.  

이것이 의미하는 바는 배열로 수행하는 방법을 이미 알고 있는 특정 종류의 작업을 찾고 있다면 Publisher에서 해당 이름을 사용해 보라는 뜻.  

예를 들어 
<img width="1214" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/54c0bd2e-15c3-4c5e-a4b2-592b2d8f3058">

* ```compactMap```: 기존에 Map Operator로 수행했을 때는 0이 반환될 수 있음. 잘못된 값이 진행되지 않도록 하고 내 모델 객체에 기록되는 것을 막는것이 더 나을 것. nil을 반환하도록 허용한 다음 nil을 필터링 할 수있음. compeactMap을 사용함으로. 클로저에서 nil을 반환하면 compactMap이 이를 필터릴 하여 stream아래로 더 이상 진행되지 않도록 함.
* ```filter``` : 학교에는 5학년 이상의 학생만 들어갈수 있다고 가정했을때, filter를 사용할 수 있다. 배열의 filter와 동일한 동작.
* ```prefix``` : 최대 3번만 졸업할수 있다고 가정했을 때, 배열에서 처음 세개의 요소를 가져와야 하는 경우. 이때는 prefix를 사용할 수 있음. 3개의 값을 수신하고 upstream을 취소하고 downstream으로 complition을 보낸다.

정리하면 NotificationCenter Publisher가 있음. 얘는 merlin이 졸업을 하는 경우를 수신함. merlin이 졸업하면 Notification에서 NewGrade 속성? 을 가져옴. 그런 다음 5 이상으로 거르고, 수신 횟수가 최대 3회 일때 merlin의 grade property에 assign함. 


# Combining Publishers
<img width="1222" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/f45f42dc-6afb-4675-9781-f6309b4b41ba">

map, filter같은건 훌룡한 api이지만 동기식 동작을 위한것임. Combine은 비동기 세계에서 작업할 때 더 빛난다.  

유용한 두가지 연산자에 대해 이야기 할 것임.  

# Zip

<img width="1222" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/72f1f450-a11c-44b1-97f9-9a9cd260f614">

예를 들어 완드를 생성하기 위해서는 3개의 오래걸리는 비동기 작업이 완료되어야 함. 3개의 작업이 완료되면 버튼이 활성화 됨. 이 때 Zip을 사용해라.  

<img width="1278" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/ffe76c9f-52ec-4dd9-9870-d8d4523283fc">

* Zip은 여러 upstream input들을 하나의 tuple로 변환함.
* "when/and", downstream으로 값을 전달하거나 취소하는 등의 작업을 진행하려면 모든 upstream 에서의 input이 필요함. 그래서 "when/and"라고 표현한듯. when this and this and this ...  

예를 들어, 1번 Publisher가 A를 생성하고 2번 Publisher가 1을 생성하면 이게 튜플을 생성하고 해당 값을 downstream으로 Subscriber에서 보낼 수 있음. 

<img width="1240" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/a68b9f47-5eea-4b9c-b002-f552eb86103c">

각각 Bool 결과를 제공하는 3개의 비동기 작업을 기다리기위해 3개의 upstream을 사용하는 Zip 버전을 사용했음.  
결과인 튜플을 버튼의 isEnabled 속성에 assign함. 


# Combine Latest

<img width="963" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c7998dc5-be3c-43ea-88f8-0171a7717f6c">

완드가지고 놀기 전에 약관동의하는 예제임. Play버튼이 활선화 되기 전에 세 가지의 스위치를 모두 활성화 해야됨. 하나가 비활성화되면 Play버튼을 비활성화 해야함. 

이것이 Combine Latest의 잡임. 

<img width="1290" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/e9a2c8aa-e0ca-45cf-8d59-055ef729b327">

* Zip과 마찬가지로 여러 upstream input들을 single value로 변환한다.
* 그러나, Zip과 달리, 진행하려면 upstream의 input이(any of its upstream, 업스트림 중 하나?) 필요하다.일종의 "When/or" 작업
* 이를 지원하기 위해 각 upstream 에서 받은 마지막 값을 저장한다. 또한 이를 단일 downstream value로 변환할수 있는 클로저로 구성함.

예를 들어 1번 Publisher가 'A'를 생성하고 2번 Publisher가 '1'를 생성하면 클로저를 실행하여 이를 문자열화하고 downstream으로 보낸다( 'A 1' 보냄 ).   
나중에 2번 Publisher가 새로운 값인 '2'를 생성하면 1번 Publisher의 이전 값과 결합하여 새 값을 보낼수 있음 ( 'A 2' 보냄 ).  
즉, upstream 변경사항에 따라 새로운 이벤트를 얻음.  

<img width="1276" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/56e3afd2-4bfd-401e-8bac-bab5e5d1515f">

예제 앱에서는 3개의 upstream 이 있음, 모든스위치는 스위칭될 때 모두 Bool상태를 사용하고, 다시 변환함. 하나의 Bool값으로 그리고 Play 버튼의 isEnabled 프로퍼티에 기록함.  
즉, 그 중 하나라도 false면 결과는 false이다. 모두 true면 결과도 true로 벼튼이 활성화 됨.  


# Try it

<img width="1260" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/2274403e-f97c-4eea-aebc-baf03b7ab595">

Combine은 앱에서 점진적으로 채택될 수 있도록 설계되었다. 이것을 사용하기 위해서 모든 것을 변환할 필요는 없다. 
몇가지 부터 해보셈. 
* NotificationCenter를 사용하는 경우 Notification을 받은 다음 그것을 보고 어떤 작업을 해야할지 결정해야한다면 filter를 사용해봐라.
* 비동기 작업들의 결과에 가중치를 두는 경우, 네트워크 작업에 Zip 을 사용할 수 있다.
* URLSession을 사용해서 데이터를 받고 JSON Decoder를 사용해서 데이터를 변환해야하는 경우, decode Operator를 사용할 수 있다.





_____


WWDC19 Combine in Practice 도 볼것. 
