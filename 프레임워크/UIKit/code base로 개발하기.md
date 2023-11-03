# code base로 개발하기

# 이점 
 앱을 효과적으로 제어, 디버깅 할 수 있고 확장에 용이합니다. 또한 여러명의 개발자와 협업할때의 충돌도 예방하기 쉽고, 작업도 쉽게 수행할 수 있습니다. 

# 순서 
1. ```Main.storyboard``` 파일을 프로젝트 네비게이터에서 지웁니다.
2. ```Main.storyboard``` 와 관련된 참조를 지웁니다. (시스템에서 스토리보드를 실행하라고 지시하는 부분들)
    * ```info.plist```파일에서 "Storyboard name"필드 지우기
    * 프로젝트 세팅, "info" 탭에서 "Main storyboard file base name" 필드, "ApplicationScene Manifest"속성의 세부속성 중 "Storyboard name"필드 지우기
3. 이제 애플리케이션에 더이상 메인 인터페이스로 설정된 스토리보드가 없습니다. 코드 기반으로 window를 초기화 해줍니다. (ios13 이상, scenedelegate에서 이하는 appdelegate에서)

# SceneDelegate 에서의 설정 및 설명
<img width="1029" alt="스크린샷 2023-11-04 오전 2 37 32" src="https://github.com/jaehoon9186/study/assets/83233720/6b8fcbe2-5302-4e32-b96f-7de8354291ce">

scene delegate 중 willConnectTo 메서드를 사용합니다.  
제공되는 주석에서도 해당 메서드를 하용하여 선택적으로 window를 구성하여 scene에 연결하라고 합니다.   
스토리보드를 사용하는 경우는 자동적으로 window가 scene에 연결된다고 합니다. 


```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = ViewController()
    // 이하 네비게이션 컨트롤러로 설정 할 경우
    // window?.rootViewController = UINavigationController(rootViewController: <#ViewController())#>
    window?.makeKeyAndVisible()
}
```
1. delegate 메서드에서 제공된 scene을 UIWindowScene으로 다운캐스팅합니다. 
2. 언랩핑된 windowScene으로 window를 초기화 해줍니다.
3. window.rootViewController 속성을 이용해 루트뷰를 지정해 줍니다.
4. 해당 window를 keywindow로 지정 및 보여지게 하기 위해서 makeKeyAndVisible()메서드를 실행해 줍니다. 
    (keywindow는 키보드와 터치와관련되지 않은 이벤트 수신, window들중 최상단 하나만 존재하는 window) 

> in appdelegate?  
> ```self.window = UIWindow(frame: UIScreen.main.bounds)```

# 참고 이미지 
* 2-1
<img width="882" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5717af45-02ae-4830-94aa-e3d4ee05959a">

* 2-2
<img width="804" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/ce1410ca-5a4e-441a-92b7-8f2a3f0465a3">
<img width="874" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/29a9760b-ef1c-450f-a856-2c9c014f69f9">

