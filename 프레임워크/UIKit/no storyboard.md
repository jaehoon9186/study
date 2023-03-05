# No Storyboard

### 스토리보드 없이 개발할때의 장점은 무엇인가?

### 어떻게 설정하면 되는가?
<img width="293" alt="image" src="https://user-images.githubusercontent.com/83233720/222954809-567cfe3b-744d-4be2-ac3f-8b1f378d767a.png">
sceneDelegate.swift 에서 window rootViewController를 설정해준다.
```swift
    // MARK: - NO STORYBOARD
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = <#ViewController()#>
        // 이하 네비게이션 컨트롤러로 설정할경우
        // window?.rootViewController = UINavigationController(rootViewController: <#ViewController())#>
        window?.makeKeyAndVisible()
    }
    
```
