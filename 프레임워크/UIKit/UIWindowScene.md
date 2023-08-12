# UIWindowScene

[Docs](https://developer.apple.com/documentation/uikit/uiwindowscene)

<img width="753" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/932ae920-8e5e-4190-b173-29c1ba09fb92">

앱에 대해 하나 또는 이상의 window들을 관리하는 scene이다. 

# Overview

 UIWindowScene 오브젝트는 scene에서 표시하는 하나 이상의 window를 포함하는 앱UI의 하나의 인스턴스를 관리함. scene 오브젝트는 사용자 기기에서 너의 window의 display(화면? 표시?)를 관리하고, 사용자가 상호작용할때 scene의 라이프 사이클을 관리함. scene이 변경되면, scene 오브젝트는 UIWindowSceneDelegate 프로토콜을 채택하는 delegate 오브젝트에 알림. scene은 또한 적절한 알림을 등록된 옵저버에 게시함. 변경사항에 응답을 위해 delegate 오브젝트나 notification observers 를 이용해라. 

 직접 window scene을 만들지 마라. 대신, 너가 구성시간(configuration time)에 UIWindowScene 오브젝트를 원한다고 명시해라. ( Info.plist 파일 scene configuration details에 scene의 클래스 이름을 포함해여서. ) 또한 앱 delegate의 application(_:configurationForConnecting:options:) method 에서 UISceneConfiguration 오브젝트를 생성할때 클래스 이름을 명시할 수 있다. 앱에서 user interacts(상호작용)을 하면, 시스템은 너가 제공하는 configuration data에 의존하는 적절한 scene 오브잭트를 만든다. 프로그래밍 방식으로 scene을 생성하기 위해서는, UI Application의 requestSceneSessionActivation(_:userActivity:options:errorHandler:) method 를 호출해라. 

## 🙋‍♂️

* UIWindowScene 객체는 하나의 scene 인스턴스를 관리함. (instance of app's UI == scene)
  * scene 객체(== window scene)는 **window 들을 표시하는것을 관리**함.
  * 사용자 상호작용에 따른 **Life Cycle을 관리**함.
* scene의 상태가 변경될 때
  * scene 객체는 **UIWindowSceneDelegate를 채택하는 delegate 객체에 알린다.** ( SceneDelegate ? )
  * 등록된 **observer에 적절한 notifications 를 게시함.**





