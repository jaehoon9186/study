# WWDC19 Architecting Your App for Multiple Windows

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

텍스트 편집앱ㅇ
