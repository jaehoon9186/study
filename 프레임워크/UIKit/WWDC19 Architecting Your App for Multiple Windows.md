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
