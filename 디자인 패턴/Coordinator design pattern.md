# Coordinator design pattern

### 참고
* [medium post by Barış GÖRGÜN](https://medium.com/adessoturkey/coordinator-design-patter-261f7438482)
* [medium post by Zedd](https://zeddios.medium.com/coordinator-pattern-bf4a1bc46930)
* [lecture basic from hacking with swift](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps)
* [lecture advanced from hacking with swift](https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios)
* [original post(The Coordinator) by Khanlou](https://khanlou.com/2015/01/the-coordinator/)
* [original post(Coordinators Redux) by Khanlou](https://khanlou.com/2015/10/coordinators-redux/)

### 목차
1. Coordinator design pattern 이란?
2. 간단 예제(navigation controller)

# 1. Coordinator design pattern 이란?
 iOS 앱이 복잡해짐에 따라, 네비게이션 컨트롤을 관리하고 각 UI컴포넌트사이의 커뮤니케이션들을 관리하는 것이 어려워졌습니다. 
 예를 들면, First VC에서 다른 Second VC를 생성하고, 네비게이션에 push하는 등의 일련의 과정은 애플리케이션의 긴밀한 결합(coupling)을 야기합니다. 이는 링크를 하드코딩했기때문에 동일한 VC를 다양한 위치에 보여주려면 코드를 복제 해야 할 수도 있습니다. first VC가 네비게이션 컨트롤러에 second VC를 present하는것도 마찬가지 입니다. 
  
 코디네이터 디자인패턴은 이러한 문제를 해결합니다. 코디네이터 패턴을 사용하면 각 VC는 어떤 VC에서 왔는지, 다음에 어떤 VC가 오는지 이러한 연결을 알 수 없도록 분리시킵니다. 대신 코디네이터 앱의 흐름을 컨트롤하고, View는 코디네이터와만 통신합니다. 

 **코디네이터는 VC간의, navigation Controller의 중재자이다.**

 MVVM-C 의 C가 coordinator입니다. 

 ### 이점?
 1. **테스트 가능성, 재사용성 증가:**  
    VC가 독립적으로 구성되었기 때문.
 2. **사용 용의성 증가:**  
    코디네이터가 화면의 전환을 중앙에서 제어하기때문에 복잡한 전환과정을 단순화하고, 안정적으로 관리하도록 도와줍니다.

# 2. 간단 예제(navigation controller)
<img src="https://github.com/jaehoon9186/study/assets/83233720/80234896-1eee-4a55-8dfd-a0b691843862" height="250" />
<img height="250" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/13e96482-b947-44e1-a99e-6ae8d41c0ba9">
  
First VC에서 각 Second VC, Third VC로 화면전환하는 간단한 앱입니다. 스토리보드를 사용하지 않고 코드베이스로 개발하였습니다. 

* ### Coordinator 프로토콜 정의
  ```swift
  protocol Coordinator {
      var childCoordinators: [Coordinator] { get set }
      var navigationController: UINavigationController { get set }
      func start()
  }
  ```
  먼저 모든 coordinator가 준수하기 위한 protocol을 정의합니다.
  childCoordinators 프로퍼티는 하위 코디네이터가 필요할 때 사용합니다.
  navigationController 프로퍼티는 VC를 표시하는데 사용되는 네비게이션 컨트롤러를 저장하는 속성입니다. 
  ```start()``` 메소드를 통해서 navigation flow를 시작하고 컨트롤합니다.
* ### MainCoordinator
  ```swift
  class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = FirstViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func showSecondVC() {
        let vc = SecondViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func showThirdVC() {
        let vc = ThirdViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

  }
  ```
  최상위의 main coordinator입니다. coordinator protocol를 채택, 준수하였습니다. 여러 VC에서 공유되므로 struct가 아닌 class로 구현합니다. (값타입, 참조타입차이)
   
* ### ViewController
  ```swift
  class FirstViewController: UIViewController {
    var coordinator: MainCoordinator?
    ...
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
  
    @objc private func goToSecondVC() {
        coordinator?.showSecondVC()
    }

    @objc private func goToThirdVC() {
        coordinator?.showThirdVC()
    }
    ...
  }
  ```
  ```swift
  class SecondViewController: UIViewController {
    var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second VIEW"
        view.backgroundColor = .blue
    }
  }
  ```
  ```swift
  class ThirdViewController: UIViewController {
    var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Third VIEW"
        view.backgroundColor = .purple
    }
  }
  ```
  각 VC는 MainCoordinator class를 참조하는 멤버 변수를 가지고 있습니다. 이를 이용하여 코디네이터와 통신하여 다음 VC로의 네비게이션을 트리거 할 수 있습니다. (First VC 참고)
  
* ### Scene delegate, mainCoordinator 초기화
  ```swift
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()

        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        mainCoordinator.start()
  }
  ```
  navigation 컨트롤러로 mainCoordinator를 초기화하고 navigation controller를 루트뷰 컨틀롤러로 설정합니다. 


