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

만약 앱이 scenes를 지원한다면, UIKit은 각각(scene)에 대해 별도의 life-cycle을 제공합니다. 

