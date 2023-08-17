# Managing your app's life cycle

<img width="986" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/d7420e48-901a-4127-8e6e-e83a26891cf3">

앱이 foreground or background에 있을 때 시스템 알림에 응답하고, 기타 중요한 시스템관련 이벤트들을 처리합니다. 

# Overview

앱의 현재 상태는(현재 상태에 따라?) 언제든지 할 수 있는 것과 할 수 없는 것을 결정합니다. 예를 들면, foreground 앱은 사용자의 주의를 가지고 있습니다. 그러므로 foreground 앱은 CPU를 포함한 시스템 리소스보다 우선순위가 높습니다. 대조적으로, backgound 앱은 반드시 가능한 작은 작업만 처리해야 하며 가급적이면 아무 작업도 수행하지 않아야 합니다. 왜냐하면 offscreen 이기 때문입니다. 앱의 상태가 변경됨에 따라, 반드시 따라서 동작을 조정해야합니다. 

앱의 상태가 변경될 때, UIKit은 적절한 delegate 객체의 메소드를 호출함으로써 너에게 알립니다.:

* iOS13 이상, [UISceneDelegate](https://developer.apple.com/documentation/uikit/uiscenedelegate) 객체를 사용하세요. scene-based 앱에서 life-cycle 이벤트에 응답하기 위해서
* iOS12 이하, [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) 객체를 사용하세요. life-cycle 이벤트에 응답하기 위해서


> ***Note***  
> 만약 앱에서 scene 지원을 하는 경우, iOS는 iOS13 이상 버전에서는 scene delegates를 항상 이용합니다. iOS 12 이하 버전에서는 시스템은 너의 app delegate를 이용합니다.

# Respond to scene-based life-cycle events

만약 앱이 scenes를 지원한다면, UIKit은 각각(scene)에 대해 별도의 life-cycle을 제공합니다. scene은 디바이스에 작동중인 앱의 UI의 한 인스턴스를 나타냅니다. 사용자는 각 앱에 대해 여러개의 scene들을 만들수 있고, 그것들을 개별적으로 보여주거나 감추거나 할 수 있습니다. 각각의 scene은 각자의 life cycle을 가지고 있기 때문에 서로 다른 실행의 상태에 있을 수 있습니다. 예를 들어,  다른 scene들이 background 나 suspended 상태에 있는 동안 하나의 scene이 foreground에 있을 수 있습니다. 

> ***important***  
> scene support는 opt-in(선택) 기능입니다. 기본 지원을 활성화 하기 위해서는 [Specifying the scenes your app supports]()에 설명한대로 [UIApplicationSceneManifest]() key를 앱의 Info.plist에 추가하세요.


다음의 그림은 scene의 상태 변화를 보여줍니다. 사용자 또는 시스템이 앱에 대한 새로운 scene을 요청 하연, UIKit은 그것을 생성하고 연결되지 않은 상태로 둡니다. 사용자가-요청한 scene 들은 foreground로 빠르게 이동하여, 화면에 나타납니다. 시스템 요청 scene은 일반적으로 이벤트를 처리할수 있도록 background로 이동합니다. 예를 들면, 시스템은 scene을 위치 이벤트를 처리하기 위해 background에서 시작할 수 있습니다. 사용자가 앱의 UI를 닫으면, UIKit은 관련 scene을 background 상태로 이동하고 결국 suspended 상태로 이동합니다. UIKit은 리소스를 회수하기 위해서 언제는지 background나 suspended 상태를 해제 할 수 있고, scene을 unattached 상태로 되돌릴 수 있습니다. 

<img width="569" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/46421f79-b855-4ac9-9fe3-356ad7a8d66f">

scene 전환을 수행하여 이하의 작업들을 수행합니다. : 
* UIKit이 scene을 앱에 연결하면, scene의 초기 UI를 구성하고 scene에 필요한 데이터를 로드합니다.
* foreground-active 상태로 전환되면, UI를 구성하고 사용자와 상호작용할 준비를 합니다. 참고 [Preparing your UI to run in the foreground]().
* foreground-active 상태를 벗어나면, 데이터를 저장하고 앱의 동작을 조용하게 합니다. 참고 [Preparing your UI to run in background]().
* background 상태로 들어가게 되면, 가능한 많은 메모리를 확보하고 app snapshop을 준비합니다. 참고 [Preparing your UI to run in the background]().
* scene이 해제될 시, scene과 관련된 공유 리소스들을 정리합니다.
* scene 관련 이벤트들 이외에도, [UIApplicationDelegate]() 객체를 사용하여 앱실행에 응답해야 합니다. 앱 시작시 해야할 것에 대한 정보는, [Responding to the launch of your app]()을 참고하세요.


# Respond to app-based life-cycle events

iOS12 이하 버전애서, 그리고 scene을 지원하지 않는 앱에서, UIKit은 모든 life-cycle 이벤트들을 [UIApplicationDelegate]() 객체로 전달합니다. app delegate는 분리된 screen에 표시되는 window들을 포함하여 앱의 모든 window들을 관리합니다. 결과적으로, 앱 상태 전환은 외부 디스플레이의 콘텐츠를 포함하여 앱의 전반적인 UI에 영향을 미칩니다. 

다음의 그림은 app delegate객체와 관련된 상태 전환을 보여줍ㄴ니다. 실행 후, 시스템은 UI가 화면에 표시되는지 여부에 따라, 앱을 inactive 상태 또는 background 상태로 전환합니다. foreground 로 실행되면, 시스템은 자동으로 앱을 active 상태로 전환합니다. 그 후에, 상태(state)는 앱이 종료될 때 까지 active와 background 사이에서 변동합니다. 

<img width="514" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/437b0a57-08e1-4306-a952-6f665f859317">

앱 전환을 사용하여 이하의 작업들을 수행합니다. :  
* 실행시(launch), 앱의 data structure와 UI를 초기화합니다. 참고 [Responding to the larunch of your app]().
* 활성화시(activation), UI구성을 완료하고, 사용자와 상호작용을 준비합니다. 참고[Preparing your UI to run in the foreground]().
* 비활성화시(deactivation), 데이터를 저장하고 앱의 동작을 조용하게 합니다. 참고 [Preparing your UI to run in the background]().
* background 상태로 들어가면, 중요작업을 마무리하고, 가능한 많은 메모리를 확보하고, app snapshop을 준비합니다. 참고 [Preparing your UI to run in the background]().
* 종료시, 즉시 모든 작업을 중지하고 공유 리소스를 해제합니다. 참고 [applicationWillTerminate(_:)](). 

# Respond to other significant events 

life-cycle 이벤트들을 다루는 것 이외에도, 앱은 반드시 이하 테이블의 나열된 이벤트들을 처리 할 수 있게 준비 되어야 합니다. 이러한 대부분의 이벤트들을 처리하기 위해서 [UIApplicationDelegate]() 객체를 사용하세요. 경우에 따라, 알림(notifications)을 사용하여 그것들에 응답을 할수 있고, 앱의 다른 부분에서 응답할 수도 있습니다. 


|||
|---|---|
|Memory warnings|앱의 메모리 사용이 너무 높을때 수신됩니다. 앱이 사용하는 메모리 양을 줄입니다. 참고 [Responding to memory warnings]()|
|Protected data becomes available/unavailable |사용자가 기기를 잠그거나 잠금을 해제할 때 수신됩니다. 참고 [applicationProtectedDataDidBecomeAvailable(_:)](), [applicationProtectedDataWillBecomeUnavailable(_:)]()|
|Handoff tasks|[NSUserActiveity]() 객체를 처리해야 할 때 수신됩니다. 참고 [application(_:didUpdate:)]().|
|Time changes|통신사가 시간 업데이트를 보내는 경우와 같은 여러가지 시간 변경에 대해 수신됩니다. 참고 [applicationSignificantTimeChange(_:)]()|
|Open URLs|앱이 리소스를 열어야 할 때 수신됩니다. 참고 [application(_:open: options:)]().|


# 🙋‍♂️

