# WWDC19 Combine in Practice


* [WWDC19 Combine in Practice]()

<img width="823" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/9a6a6970-f19f-4125-9d24-f798aa15bfd9">



<img width="702" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/0720806c-1d40-404f-921c-51379d345bad">

예제와 함께 설명합니다. 
한마법사가 있고, 그는 자신이 설립한 새로운 마법사 학교를 위해 앱 작업을 하고 싶어합니다. 기능 중에 하나는 다른 마법사들이 공유한 마법을 다운로드 할 수 있게 하는 기능입니다. 

컴바인을 이용해 Trick Name에 접근? 해봅시다. 

<img width="1241" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/08f15b1c-7db0-494d-b9b7-f4f559bd49f7">

<img width="1232" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/39c14e9d-dd70-4b1e-b218-d8cbe237435f">

<img width="1223" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/8f2533ad-ddd7-4c71-82f4-dd5eee33d57f">

NotificationCenter에는 Combine에서 제공하는 메소드가 있습니다. notification.name을 이용해 퍼블리셔를 리턴하고 이는 이미지와 같이 <Output, Failure>로 구성되어 있습니다. 
이를 오퍼레이터들을 거쳐 원하는 타입으로 변환해봅니다. 
시퀀스 고차함수인 맵과 비슷한 기능을 가진 map 오퍼레이션으로 Noritication을 Data로 변환하고, JsonData인 data를 tryMap을 사용하여 MagicTrick 타입으로 디코드 합니다. 

<img width="1117" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/d727c010-edf2-4a4e-890a-c76c576b3423">

decode 오퍼레이터도 따로 제공을 해서 이와같이 표현도 가능합니다. 


# Error Handling
<img width="908" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5ddd3338-20e6-495d-a7df-14f9d664587c">


모든 Publisher와 Subscriber는 자신이 생성하거나 허용하는 failure를 describe할 수 있습니다. 
error handling을 convention-based(규칙기반?)으로 남겨두고 싶지 않아서 Combine에 구축했다고 합니다. 


Combine에서는 오류가 발생할 경우 이에 대응 하고 복구할 수 있는 다양한 연산자를 제공합니다. 

간단한 것중에 하나는 fail이 절대 일어날 수 없다고 하는 것입니다. 
<img width="1220" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/ea807be5-9e19-4a6c-b6cf-14644ed18b83">
이제 리턴된 publisher의 failure 타입은 Never가 됩니다. 


upstream Publisher와 연결된 downstream Subscriber 사이에 assertNoFailure 오퍼레이터가 있습니다. 이 오퍼레이터는 값이 수신되면 전달 할 것입니다. 
그러나, 만약 업스트림으로부터 error가 도착하면 프로그램은 단순히 트랩을 수행할뿐이고, 이는 매지컬한 결과가 아니다. 
(However, if an error arrives from upstream, out program will simply trap, and that's really not the most magical outcome for our wizardly customers.)

<img width="1130" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/f060c552-6352-4791-833d-03da2563f186">

다행히, failure의 작업을 수행한느 여러 오퍼레이터들이 있습니다. 
<img width="1236" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/6da1ec9a-a294-4d99-83d9-4c89101a111c">
upstream Publisher에 대한 연결을 다시 시도하거나 error를 다른 타입으로 변환 할 수 있습니다. 

# Catch 오퍼레이터

catch를 사용하면 upstream Publisher에서 failure가 발생한 경우 recovery Publisher를 정의한느 클로저를 제공합니다. 

이전과 마찬가지로 upstream으로부터 downstream으로 까지 데이터가 전달됩니다. 그러나 오류가 발생하면 기존의 upstream 연결이 종료됩니다. 

<img width="1070" alt="스크린샷 2023-11-22 오전 12 05 47" src="https://github.com/jaehoon9186/study/assets/83233720/f9d98443-09c1-4ddd-ad51-fa2472e94242">

그런다음 recovery 클로저를 호출하여 새로운 publisher를 생성하고 이를 구독하고 값을 자유롭게 받을 수 있습니다. 

<img width="1078" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/09b492bc-380f-4758-b5f3-9709e16f9b65">

이런식으로 catch연산자를 사용하면 원래 Publisher를 새로운 publisher로 교체하여 error를 복구할 수 있습니다. 

코드에서 보면, 
<img width="1120" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/55be68c2-4225-4ec9-942c-e77b392a6291">

Using catch is pretty much the same as any other operator, although the closure here expects for us to return a Publisher. 

Combine은 publish하기위한 value가 이미 있는 경우를 위한 special Publisher를 정의합니다. ( Just() )
이를 통해 Publisher는 더 이상 실패 할 수 없습니다. 

<img width="820" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/1ecf8767-10e2-403b-b807-00ae154ef9a9">

catch에 의해 Recovery Publisher로 전환하면 다시는 다른 notification을 볼 수 없을 것 입니다. 
우리가 원하는 것은 decode를 실해하더라도 기존의 upstream에 대한 연결을 유지하면서 placeholder를 사용하는 기능입니다. 
그거슨 바로.. flatMap 입니다. 

# flatMap 오퍼레이터 
<img width="791" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/57779f06-eb9a-4e87-816d-7d7cf848e3fc">

flatMap은 map과 유사하게 동작해서 이름이 붙여졌습니ㅏㄷ. 
upstream Publisher로 부터 값을 전달 받고, flatMap은 downstream으로 값을 제공할 nested publisher를 처리합니다. 

<img width="1055" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c88bb14a-602c-4d0c-ac54-ac6768e15a2b">

이 경우에 flatMap에 도착했을때, Just, decode, catch로 새로운 Publisher를 구독 하여 결과 값을 downstream으로 제공합니다. 
에러가 났을 경우, catch 에서 recover pulisher로 반환됩니다. 이로 실패하지 않도록 보작합니다. 

<img width="1136" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/aac5db72-b24b-4677-8245-a687287988fd">

이로서 Upstream failure를 처리했습니다. flatMap 이후에 <MagicTrick, Never> publisher 리턴합니다. 

이제 pubish 해본다면, Publisher(for:) 오퍼레이터를 사용하여 가능합니다. 

키페스를 사용하여 새 publisher르르 생성합니다. 이 경우 String

이 시점에서, 강력한 기능을 제공하는 마지막 종류의 오퍼레이터가 있습니다. 

# Scheduled Operators

<img width="960" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/38a7ec2b-bcf2-4ced-b3d9-8bbdbc3b53e5">

Scheduled 오퍼레이터는 실제상황에서 일정을 예약하는 것과 마찬가지로 특정 이벤트가 언제 어디서 전달 되는지 설명을 한는 데 도움을 줍니다. RunLoop, DispatchQueue에서 지원되며 이러한 오퍼레이터의 사용 예로 이벤트 전달을 딜레이 하는거 같은 오퍼레이터가 있습니다. 

<img width="1019" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/1b0740b5-7db5-4395-bd15-cd5712627f63">

지정된 속도보다 더 빠르게 도착하지 않도록 보장하는 throttle도 있습니다. 
downstream 수신 이벤트가 특정 thread 나 queue에 전달되도록 보장하는 receive(on:) 오퍼레이터도 있습니다. 
이 오퍼레이터를 사용해서 항상 메인큐에 전달 되도록 보장하겠습니다. 

<img width="1142" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/d1f0ff22-014a-467c-9400-9f16dab54d9a">

output은 변경되지 않는것을 볼수 있습니ㅏㄷ. 

<img width="1151" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/048a83cb-69b4-4696-943e-6043b1ddf1ea">

메인 스레드에서 UI를 업데이트 해야 하는 AppKit 또는 UIKit으로 작업하는 경우 바로 시작할 수 있습니다. 이미 메인 스레드에 있습니다. 

# Publishers
<img width="939" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/26a6752a-3c3c-470e-b072-c73130bb91a5">

순차적으로 강력한 유형의 값을 생성하기 위한 과정에서 각 연산자의 초기 레시피로 시작했습니다. Just의 경우와 마찬가지로 publisher가 값을 동기식으로 생성할 수있다는 것도 확인했습니ㅏㄷ. 
NotificationCenter와 같이 비동기 식으로 수행됩니다. 

publish value를 다른 초점으로 바라보겠습니다.
그것을 받아들이는 것으로. 

# Subscriber
<img width="1120" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/d3e0f3ea-ff82-44b6-9e2c-2eb24d11ab5a">

publiser와 마찬가지로 두가지 유형이 있습니다. (이전 세션 복습) 그리고 3가지 메서드가 있습니ㅏㄷ. 이러한 메서드가 호출되는 순서는 잘 정의 되어 있으며 다음의 세가지 규칙에 따라 결정됩니다. 

## Valid Streams role 1. Subscription
<img width="1052" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/1b9620de-53de-4726-ad81-0488da0b635a">

첫번째 규칙은, publisher는 subscribe 호출에 대한 응답으로 receive(subscription:)을 정확히 한 번 호출합니다. 


## Valid Streams role 2. Zero or more values
<img width="1036" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b3696c7d-ceb8-43b3-b10c-1b3cc5b8eae2">

publisher는 subscriber가 요청한 후 downstream으로 0개 이상의 값을 제공할 수 있습니다. 

## Valid Streams role 3. Completion
<img width="1020" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/96bd2425-fc24-4e51-86ab-5d1476a74b2b">

publisher는 최대 한 번의 completion을 보낼 수 있으며 해당 completion은 publisher가 완료했거나 오류가 발생했음을 나타낼 수 있습니다. completion이 전송되면 더 이상 값을 내보낼 수 없습니ㅏㄷ. 

<img width="1061" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/565ab19e-4b2c-4605-9e12-faab258032e8">

요약하면 subscriber는 단일 구독을 수신하고 그 뒤에 0개 이상의 값이 옵니다. publish가 완료되었거나 실패했음을 나타내는 단일 완료로 종료 될 수 있습니다. 
완료는 옵셔널이기 때문에 가능, 이전의 notificationCenter 예제 처럼 많은 스르팀이 잠재적으로 무한할 수 있습니다. 



# Kinds of Subscribers
<img width="791" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/bdf6bdf1-47e6-41e5-89a0-d032ac69a0db">
Combine에서는 다양한 종류의 subscriber를 지원합니다.

<img width="1021" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/192a5552-4996-44ad-8888-df27ec765c31">

assign(to: on:) 오퍼레이터를 사용하여 추가했습니다. 

그러면 upstream publisher에서 내보낸 모든 값이 지정된 개체의 지정된 키패스에 할당됩니다. 
그리고 이 시점부터 기본적으로 모든 publisher를 자유롭게 선택하고 값에서 모든 속성에 할당할 수 있습니다.  
또한 이 오퍼레이터는 caancellation token을 생성합니다. 나중에 구독을 종료하기 위해 호출 할 수 있는 

취소에 관해 이야기 합니다.  

# Cancellation

<img width="870" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/a113f0f8-6eb9-40d2-9bef-fdb4f1d51b3e">


publisher가 이벤트 전달을 완료하기 전에 구독을 종료할 수 있는 것이 종종 유리하기 때문에 Combine 형태로 취소 기능을 구축했습니다.  
구독과 관련된 리소스를 확보하려는 경우 더 .. 

취소는 최선의 노력이지만 필요한 경우 subscriber를 구독 취소 할 수 있는 수단을 제공합니다.  

<img width="1093" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/795fb479-ff28-4c81-a319-a0979c6b1a86">

Deinit에서 자동으로 취소를 호출하는 AnyCancellable이라는 유용한 편의 기능을 소개합니다. 

이렇게 하면 명시적으로 취소룰 호출해야하는 횟수가 크게 줄어듭니다. 

강력한 메모리 관리기능!. 

<img width="846" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/db9d43ef-0aec-4632-8534-114de1faaf44">

이번엔 sink 오퍼레이터를 이용해 구독했습니다. 클로저를 제공하면 이제 수신된 모든값이 호출되고 원하는 side effecty를 수행할 수 있습니다. 
Assign과 마찬가지로 구독을 종료하는데 사용할 수 있는 cancellable 을 리턴합니다.  


세번째 형태의 구독은 약간 하이브리드 입니다. 

# Subjects 
<img width="1028" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b3eee402-e6c5-432b-ab29-438326575a2e">

Subject는 publisher와 subscriber처럼 행동합니다.  

일만적으로 수신된 값의 멀티 캐스팅을 지원하며 특히 중요하게도 값을 명령적으로 보낼 수 있습니다. 

이는 기존 코드기반으로 작업 할 때 가장 중요합니다. 

<img width="836" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/729a085f-a056-4958-9ab1-33f4f2ef94b4">
subject를 사용하면 여러 downstream Subscriber들에게 브로드캐스트 할 수 있을 뿐만 아니라 명력으로 값을 보내는 것이 가능. 

그리고 수신된 모든 값은 downstream subcrciption에게 브로드캐스트 됩니다.

<img width="990" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/6f697260-f605-4b1e-b8c1-7aaee76ea47a">
값이 upstream publisher에 의해 생성되는 경우도 마찬가지 입니다. 

# Kinds of Subjects 
combine에서는 두가지 종류의 subject를 지원합니다. 
<img width="1039" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5b13723b-19bf-4ccf-b6f3-215b90e16887">

Passthrough subject는 값을 저장하지 않아, 구독 후에만 값을 볼 수 있습니다.  
CurrentValue subject는 마지막 값의 기록을 유지하여 새로운 subscriber가 따라잡을 수 있는 기회를 제공합니다.  

<img width="941" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/6e6cd7b3-9e12-421f-bafc-ddf0d02c2cf7">

subject를 생성하는 것은 output과 failure타입을 지정하고 constructor를 호출하는 것만큼 쉽습니다. 

subject는 upstream publisher를 구독할 수 있다는 점에서 구독자 처럼 동작합니다.  

뿐만 아니라, sink와 같은 것을 포함하여 publisher처럼 스스로 subscriber 들을 생성합니다.  

send()를 사용하여 명령적으로 값을 보낼 수 도 있습니다.  


실제로 subject가 너무 자주 도착하므로 passthrrough Subject를 스트림에 주입하기 위해 share() 오퍼레이터도 정의합니다. 


마지막으로 네번째 종류의 subscriber, 이는 SwiftUI와 통합됩니다. 


# Working with SwiftUI
<img width="1121" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/53fbe8c3-fd9e-4862-a3ff-2ff6b934438e">

SwiftUI의 놀라운 점 중 하나는 애플리케이션의 종속성을 설명하기만 하면 프레임워크가 나머지를 처리한 다는 것 입니다. 
Combine의 관점에서 이는 데이터가 언제 어떻게 변경되었는지 설명하는 publisher를 제공해야 함을 의미합니니다.  

그렇게 하려명, custom type을 BindableObject 프로토콜에 맞추기만 하면 됩니다.  

<img width="1155" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/8acd3c6c-eb6c-4417-a81b-d190e4f27b61">

publisherType은 실패하지 않는 퍼블리셔입니다. 이는 publisher에 도달하기 전에 upstream 오류를 처리하도록 강제하기 때문에 UI 프레임워크 작업에 환상적입니다.  

didchange프로퍼티라는 속성이 변경될 때 이를 알리는 실제 publisher를 생성합니다.  

<img width="902" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/58e9035e-cfff-46d3-b571-7e9b8478c185">


모델이 있고, BindableObject를 채택했ㅅ브니다. 

그리고 subject를 사용하여 모델 객체가 변경된 시기를 설명합니다.  

And we really don't need out subject to signal any specific kinds of values because the framework will figure that out by what we call form our body method. and so we'll choose void as the output bype of our subject. 

이와 같이 subject를 사용하면 많은 유연성이 제공됩니다. 이제 개체가 변경될 때 마다 명령적으로 메시지를 보낼 수 있습니다. 

지금은 property observer 몇을 사용해 subject에 대해 직접 send를 호출하여 속성중 하나가 변경 될 때 모델 객체가 변경 되었음을 나타냅니다.  

다음으로 이 모델을 다음과 같이 SwiftUI 뷰에 연결해야 합니다.  

SwiftUI가 자동으로 publisher를 검색하고 구독할 수 있도록 하는 객체 바인딩으로 모델을 선언하겠습니다.  
그런다음 body 속성 내에서 모델의 속성을 참조합니다.  

모델이 변경되었다는 신호를 보낼때 마다 자동으로 새 body를 생성합니다. 


# 

<img width="706" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5fc85459-c4cb-4cd8-9e9d-29f7b94ea24c">

# Integrating Combine 
<img width="1206" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/266c7560-7cab-4f4b-8270-0e866603edd1">

각종 예들 
