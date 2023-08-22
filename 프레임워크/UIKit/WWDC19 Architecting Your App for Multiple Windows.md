# WWDC19 Architecting Your App for Multiple Windows

[WWDC19 Architecting Your App for Multiple Windows](https://developer.apple.com/videos/play/wwdc2019/258/)

<img width="1210" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/ef03a259-a910-4e77-8c17-7b7b4b864b6d">

먼저 멀티 window 앱을 설계하는 방법에 대해 이야기 합니다.   
iOS13에서, multiple window를 지원하는 것은 기존의 앱을 더욱 유용하게 만들고 생산성을 크게 높일 수 있는 환상적인 방법이라고 소개합니다. 

세가지 주제로 세션을 진행합니다. 

1. **Changes to app lifecycle**  
  iOS13에서 multiple window를 사용할 수 있도록 하는 application life cycle의 변경사항에 대해 간단한 개요로 소개합니다. 
2. **Using the scene delegate**  
   UIScene delegate에 대해 자세히 알아봅니다. scene delegate에서 어떤 작업을 하는지 이야기합니다. 
3. **Architecture**  
  사용자에게 일관되고 원활한 멀티태스킹 경험을 제공할 수 있도록 ArchitectureKit의 몇가지 모법 사례를 소개합니다. 




# App Delegate Responsibilities

<img width="1270" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/ea95915f-4adb-41f0-a575-814c1bf44d4f">

iOS12 및 이전까지의 버전에서 App delegate의 역할과 책임에 대해 먼저 이야기합니다.  

App delegate는 두가지의 기본 역할을 수행했습니다.  

1. **Process Lifecycle**  
  앱에 프로세스 레벨의 이벤트를 알리는 것. 따라서 시스템은 프로세스가 시작되거나 종료되려고 할 때 app delegate 에게 알린다. 
2. **UI Lifecycle**  
  앱에 UI 상태를 알리는 것. 시스템은 `applicationWillEnterForeground(_:)`, `applicationDidBecomeActive(_:)`와 같은 몇가지 방법을 통해 UI상태를 알려 준다. 

<img width="849" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/3d5f8129-3266-41ed-8fa5-6c861aee0f7e">

이것은 iOS12 이하의 버전에서는 괜찮습니다. 왜냐하면 App에는 하나의 프로세스와 일치하는 하나의 UI가 있기 때문입니다.  

<img width="1289" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/e24d9a02-20c9-4e19-b850-f2325071f60a">

따라서 App delegate는 이렇게 보일 수 있습니다. (축약함)

옵션과 함께 실행을 완료하면, 몇가지 작업을 수행합니다.  
첫째, 데이터 베이스에 연결하거나 데이터 구조를 초기화 하는 것과 같은 non-UI global setup을 일회성으로 수행합니다.   
둘째, UI를 설정합니다. 

이것은 iOS12 이하 버전에서는 유효하지만 iOS13이후의 패턴은 유효하지 않습니다.  

<img width="909" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/de02700a-8635-408d-a0d6-2d02d74c3fc5">

왜? 애플리케이션은 여전히 하나의 프로세스만 공유하지만 여러 UI 인스턴스 또는 scene session 들을 가질 수 있기 때문입니다.  

# App Delegate Change

<img width="1263" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b1b6e8df-2534-4fb8-b7db-c06d0a5eced6">

이는 app delegate의 책임이 약간 변경되어야 함을 의미합니다. 여전히 Process lifecycle을 책임지지만, 더이상 UI lifecycle 관련된 어떤것도 책임지지 않습니다. 

대신 UISceneDelegate가 모두 처리합니다. 

이러한 변경사항은 app delegate에서 수행했던 UI 설정 또는 해제 작업은 Scene delegate로 마이그레이션 해야한다는 것입니다. 

<img width="1299" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/328f2d41-579f-41f6-898b-100df434b1ee">

실제로, iOS 13에서, scene lifecycle을 채택하면 UIKit은 ui 상태와 관련된 old app delegate 메서드를 호출하는 것을 중단할 것입니다. 

대신, 새로운 scene delegate 메소드를 호출할 것이고, 대부분이 1 to 1 맵핑되어 있기 때문에 매우 간단합니다. 

no 걱정, Scene을 지원한다는 것이 iOS12 이하의 버전 지원을 중단하는것을 의미하는것은 아님.
만약 다시 배포해야하는 경우, 이러한 메소드 세트를 간단히 유지할수 있으며, UIKit은 런타임에 올바른 세트를 호출할 것입니다. 

<img width="941" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/872c7054-27c1-4c30-b446-38fcec2f813b">

정확한 delegate 메소드를 살펴보기전에, app delegate가 받는 추가적인 책임이 하나 더 있습니다. 

새로운 scene session이 생성될 때, 존재하는 scene session이 삭제될 때 시스템은 app delegate에 알립니다. 
이러한 life cycle을 구체적으로 보겠습니다. 

### 앱 실행시 
<img width="1220" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/2c14b9e6-ec76-44bb-96fd-44f61e1c8b9c">

나는 블루앱을 개발하고 있고, 블루앱을 처음 실행하는 경우를 가정합니다. 

호출 스택을 살펴보면. 
1. **먼저, app delegate는 `didFinishLaunching` 옵션과 함께 실행을 완료할 것입니다.**
    ![image](https://github.com/jaehoon9186/study/assets/83233720/0349879c-ca0b-456a-9784-c7d95d68895c)  
   ( app delegate에 이부분 같음 )  
   여기서도 일회성 Non-UI 설정을 하는 것이 좋습니다.
2. **그 직후에 시스템은 scene session을 생성할 것입니다. 그러나 UI Scene을 생성하기 전에 애플리케이션에 UIScene configuration(구성?)을 요청합니다.**
    <img width="770" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/79bdefd9-7004-4c60-866f-ea1c66847051">  
   ( 참고 )  
   <img width="1272" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/2b24a491-5127-4906-9638-23e5347e7b5b">
    이 configuration은 무슨(?) scene delegate와, 무슨 story board와, 구체적으로 명시한다면 무슨 scene subclass 를 만들려는 scene과 함께 만들지 지정합니다.
   info.plist로 넣어줄 수 도 있고, 코드로 넣어줄 수도 있습니다.

   이것은 옳바른 configuration은 선택할수 있는 기회를 제공합니다. main scene configuration이 있을수도있고, accessory scene이 있을 수도 있습니다.
   따라서, 옳바른 scene configuration을 선택하기 위한 context로 사용하려면, 제공되는 옵션 파라미터를 확인해야합니다.

   <img width="1231" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/fd2f3025-f077-4bee-ab3d-4a8a28bd33b0">

   예를 들어, info.plist에 정의하고 나면 정말 간단합니다. 수신 sessions의 role을 확인하면서(?) name으로 참고하기만 하면 됩니다.

   앱실행됨. 이제 scene session을 확보했으나 아직 UI를 볼수 없습니다. 

3. **session 연결?**  
   <img width="1265" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/ab13d167-ce38-4b4c-8f31-b2ee33df7815">

   여기에서 새로지정된 UI Window 를 이용해 초기화합니다. 제공된 window scene을 전달한다는 것을 알수 있습니다.

   그러나 중요한 것은 window를 구성하기 위한 사용자 활동(activity) 또는 상태복원 활동(activity)도 확인해야 한다는 것 입니다.(이건 잠시 후에)

   이제 앱이 보입.


### background 로
사용자중 한명이 위로 스와이프하여 홈화면으로 돌아가면 어떻게 될까요? old familiar는 active상태를 사임하고, scene delegate에 메소드를 호출하여 background로 들어갔습니다. 

<img width="1240" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/920729b1-ebb8-4e63-8672-b4ba31723db3">

but, 이제 흥미로운 것이 있습니다. 

<img width="1274" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/31c718a3-e474-4055-9e5f-f7f2e805c0ee">

어느시점 이후 scene은 연결이 끊어질 수 있습니다. 리소스를 회수하기 위해, 시스템은 scene을 background로 들어가는 그러한 시점 이후에 메모리에서 scene을 해제할 수 있습니다.  
이는 또한 scene delegate가 메모리에서 해제됨을 의미하고, scene delegate가 보유한(붙잡고있는) 모든 window 계층, view 계층 도 마찬가지로 메모리에서 해제됨을 의미합니다. 

이렇게 하면 해당 scene과 관련된 애플리케이션의 메모리의 큰 리소스를 해제 할 기회를 주는 것입니다. 
그러나, scene이 나중에 재연결될수 있기때문에, user data나 상태를 영구적으로 삭제하지 않는 것이 중요합니다. 

### 종료 시
<img width="1244" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/dcf9c0ab-03c8-4f81-afc3-511d0b6f19f3">

사용자가 swip up으로 앱을 종료한다면 어떤일이 벌어질까요? 시스템은 app delegate의 didDiscardSceneSession을 호출합니다.

<img width="1268" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/8a1e336e-79ed-41f9-86c8-679dcbcbbfa3">

텍스트 편집앱앱의 저장되지 않은 초안과 같은 scene과 관련된 유저 상태나 데이터 같은것을 실제로 영구적으로 지울수 있는 기회를 제공하는 것입니다. 이제, 사용자중 한명이 app process가 not running 하는 동안 swiftcher에서 swiping up을 하여서 하나 이상의 UIScene을 제거되는 것도 가능합니다. 만약 process가 notrunning인 경우, 시스템은 disccarded(제거된? 버려진?) session들을 추적하고, 앱의 다음 실행 직후에 이를 호출합니다. 

# Architecture

이제 앱에 통합하는 것을 고려할 수 있는 몇가지 아키텍처 패턴에 대해 알아보겠습니다. 

<img width="1258" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5661aa34-6917-42b8-a3b8-6b28475bb200">

state restoration(상태 복원?)에 대해 이야기 하겠습니다. iOS 13에서는 상태복원이 더 이상 중요하지 않습니다. 
앱에서는 scene-based 상태복원을 구현하는것이 중요합니다. 
왜그럴까요?

<img width="960" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/166eb3c2-d549-47a2-aa6c-ccfec2cf21a7">

예를 들어 문서앱이있고, 자동차여행을 계획하고 있으며, 4개의 다른 session이 열려 있습니다. 

하지만 packing list와 agenda에 집중하고 있는 중입니다. 어느 시점에서, 다른 두가지의 scene들은(road trip, attendees)는 시스템에 의해 연결 해제되고, released(해제)되었습니다. 

여기서 상태복원을 구현하지 않으면, road trip으로 다시 돌아가게 될 때, 이전에 작성했던 상태로 돌아가지 않을 것 입니다. 편집 중이던 document앱의 scene으로 가지 않을 것임. 

대신, 새로운 window인것 처럼 시작할 것입니다. 이것은 좋지 못한 UX입니다.  

어떻게 해결 할 수 있을까요?  

<img width="1277" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/322c0c02-128c-4b75-b968-93d60a156d8b">

iOS13에서는 완전히 새로운 scene-based 상태복원 API가 있습니다. 이것은 매우 간단합니다.  view 계층구조를 인코딩하지 않고, 대신 window를 다시 만들수 있는 상태를 인코딩하는 방식으로 작동합니다. 

이것은 NSUserActivity를 기반으로 합니다. 따라서, 애플리케이션이 spotilight search 나 handoff와 같은 강력한 기술을 활용하는 경우, 앱의 상태를 인코딩 하기 위해 이와 같은 동일한 activity를 사용할 수 있습니다. 

iOS13에서는 시스템에서 반환하는 상태 복원 아카이브가 나머지 애플리케이션의 동일한 data protection class 와 일치 한다는 점도 also worth nothing in iOS13


<img width="1241" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/97393d5c-9675-4c07-a259-5945b11d95e5">

코드를 봅시다. scene delegate에서, 우리는 scene에 대한 state restoration activity(상태복원활동?)을 구현하고 현재 window에서 가장 활동적이고 관련있는 user activity form을 찾는 메소드를 호출합니다. 그런다음 반환합니다.  

얼마후, scene이 foreground로 재진입하고, 연결된 상태가 되면, session이 state restoration activity(상태복원활돌?)에 포함되어 있는지 확인합니다. 만약 포합되어있다면. 그 activity를 사용합니다. 포합되어있지 않다면, 어떠한 state 없이 완전히 새로운 window를 만들 수 있습니다. 

이것은 무슨일이 있어도, 사용자는 background에서 scene이 연결이 끊어지는것을 알아차리지 못한다는 것을 의미합니다. 


<img width="1286" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c51b9329-8505-4877-a915-b720550c29ad">

마지막으로, mutiple window 지원을 채택했을때 발생할 수 있는 하나이상의 중요한 이슈에 알아 보겠습니다.  

이것이 앱의 scene을 동기화 상태로 유지하는 것이 가장 좋은 방법입니다. 구체적으로 보면.

<img width="1241" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/13322800-f05a-49dd-987b-6aea90c0eae4">

chat 앱을 작업중입니다. iOS13의 muliple window 지원을 추가했습니다. 

그리고 친구와 채팅했습니다. 두개의 같은 대화를 두개의 다른 view controller와 두개의 다른 scene에서 동시에 보고 있는 중입니다. 

한개의 VC에서 메세지를 보냅니다. 이미지와 같이, 한개의 scene에서만 업데이드 되었습니다. 

왜 그럴까요? 

<img width="1257" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/80a90aea-98ac-422b-8722-26c0ce6da02b">

많은 앱이 view controller가 이벤트를 수신하는 방식으로 구성되어 있습니다. (아마 button tap을 통해~ ). 그런 다음 ViewController는 자체가 UI Update를 합니다. 그 후에, ViewController는 model 또는 model controller에게 알립니다. 이것은 하나의 UI 인스턴스이 대해서만 이야기 할때는 대부분 괜찮습니다.  

그러나 동일한 데이타를 보여주는 다른 scene에서의 viewController를 도입하면, 새로운 viewController는 새로운 데이터로 자체 업데이트 하라는 알림 을 전혀 받지 않습니다. 

이것이 문제입니다. 

우리는 해결할 수 있습니다.  

<img width="1291" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/51289923-baff-4c31-9382-3016cb0cd197">

구조적으로, VC는 이벤틑 받은 후에, 즉시 그리고 오직 model controller에게만 알립니다. 그런다응 model controller는 관련 subscriber나 view controller에게 알립니다. 새로운 데이터로 업데이트 해야 한다고 알릴 수 있습니다. 


이를 수행 할 수 있는 방법에는 여러가지가 있습니다. delegate, notification, Combine 프레임워크 를 사용할수 있습니다.   


<img width="1268" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5964acfc-de53-4d62-8825-31b93c2ed051">

하지만 앱에 통합하는 것을 고려할 간단한 swift 예제를 보겠습니다.  

메시제를 보낼때 버튼을 누르면 호출되는 메서드는 위와 같습니다. message model 객체를 생성합니다. VC는 자체 view를 업데이트 합니다. 그런다음 유지하도록 model controller에게 알립니다. 

<img width="1242" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/f14e69e2-cee7-4917-9036-9bc3d042dfaf">

우리가 가장 먼저 해야할 일은 Vc가 자신의 view state를 변경해서는 안된다는 것입니다. instead, 해당 코드를 제거할것이고, 나중에 추가 할 것임. 

<img width="1223" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/a99fcb53-36c5-45f4-9fa7-8a100170ee80">

이제 model controller의 add 메소드가 무엇을 하는지 살펴보겠습니다.  

간단히, 새 메시지를 유지하는 것 뿐 입니다.  

그러나 우리는 실제로 업데이트된 VC나 연결된 scene이 있는지 model controller가 알리길 원합니다. 

<img width="1274" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/592e83ac-ff54-43ff-847f-0903973fbc6f">

어떻게 업데이트를 보내나요? 우리는 강력하게 유형화(strongly typed)하고 쉽게 debuggable, testable할 수 있는 (이러한 이벤트를 package하기 위한) 구조화된 방법을 원합니다. 

이제, 새로운 type을 생성하고 업데이트된 이벤트를 호출할 것입니다. 

<img width="1244" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/c9b28a11-f7d6-4928-a93f-fd7ad2bfe55e">

associated values가 있는 swift enum 입니다. 

NewMessage type을 추가하겠습니다.  
이는 model controller가 새로운 message를 생성한다음 관련된 vc나 scene으로 보낼 객체입니다. 
우리는 이것은 post하고 싶기 때문에, 우리는 NSNotification center을 이것을위한 backing store(백업저장소?) 로 사용하겠습니다.  

새로운 업데이트 이벤트를 생성한다음 모든 subscriber들에게 게시할 수 있는 편리한 방법을 추가 했습니다. 구현은 매우 간단합니다.  


NewMessageNoificationName 채널에 알림만 post하면 됩니다. 하지만 여기서 중요한점은 notification 객체에 UpdateEvent 객체 자체를 포합해야 한다는 것입니다. 잠시후에 살펴 보겠지만 이는 매우 유용할 것입니다. 

<img width="1200" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5b22743d-a5f8-4532-a99c-476ba01b9404">

이제, model controller가 새로운 메시지가 추가된 것을 전달 받으면, 이를 유지한 후, 새로운 이벤트를 만들고, post() 메소드를 호출 할 수 있습니다. 

<img width="1252" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/1664da3e-6e32-4814-be7b-5f3dde872322">

그런다음, View Controller를 어떻게 변경해야하는지 보면, 우리는 새로운 이벤트를 observe 합니다.  이경우, NewMessageNotificationName 입니다. 

그런다음, argument에 Norification을 받는 handler 메소드를 만듭니다. 업데이트 이벤트를 notification 객체로 전달한다면, 그 이벤트를 notification으로 부터 바로 가져올수 있다는 점을 기억하세요. 

그런다음, 이벤트의 종류에 따라 쉽게 스위칭 할수 있고, associated enum을 만들었기때문에 메시지를 꺼낼 수도 있습니다. 

이제, 이 곳에서 UI를 업데이트 할 수있습니다. 


<img width="1756" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/d291c0d0-bd29-4c51-adb5-41e0b63493af">

이제 모든 scene이 업데이트 됩니다. 

<img width="1269" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/d380ffaa-c182-4809-b0e3-91e09680f54c">

scene delegate와 app delegate의 차이점과 책임에 대해 알아보았습니다.  

scene delegate의 몇가지 중요한 메소드와 어떤 작업을 수행해야 하는지 살펴 보았습니다.  

또한 state restoration이 왜 중요한지 어떻게 scene-based API를 활용하는지에 대한 것도 이야기 했습니다.  

마지막으로, 동일 한 데이터를 공유하는 동안 동기화된 scene을 유지하는것과 같은 one-way(단방향) 데이터 흐름을위한 상위레벨의 패턴들에 대해 이야기 했습니다. 

