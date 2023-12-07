# Coordinator design pattern 2
코디네이터 패턴에 딥다이브 해보자. 

### todo
* 구조
  * Application Coordinator
  * Main Coordinator
  * in navigation Control
  * in Tab Bar Control
  * in ChildViewController
* ChildCoordinator ?
* remove child
* pop ChildCoordinator in navigation controller

### 참고
* [Coordinator pattern with Tab Bar Controller/ Medium Post](https://somevitalyz123.medium.com/coordinator-pattern-with-tab-bar-controller-33e08d39d7d)
* [Swift Tutorial: How to use Coordinator Pattern with MVVM - Advanced Navigation in UIKit & SwiftUI/ Youtube](https://www.youtube.com/watch?v=wpw3l_jTuOo&t=2779s)
* [Advanced coordinators in iOS/ tutorial](https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios)
* [Coordinators – Soroush Khanlou/ Youtube Video](https://www.youtube.com/watch?v=a1g3k3NObkE)
* [How to implement the coordinator pattern in a new project/ blog post](https://malinsundberg.com/architectures/implementations/how-tos/2018/03/06/coordinator-implementation)


# 구조

### Application Coordinator  
window의 제어를 app coordinator에서 합니다.  
만약 온보딩뷰, 로그인뷰가 필요하다면 이곳에서 바인딩하여 분기처리를 하변됩니다. 

```swift
// in Scene Delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var applecationCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let applicationCoodinator = ApplicationCoordinator(window: window)
        self.applecationCoordinator = applicationCoodinator
        applicationCoodinator.start()
    }
}
```

```swift
import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow?
    var childCoordinator = [Coordinator]()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let nc = UINavigationController()
        window?.rootViewController = nc

        let mainCoordinator = MainCoordinaotr(navigationController: nc)
        self.childCoordinator = [mainCoordinator]
        mainCoordinator.start()

        window?.makeKeyAndVisible()
    }

    // 또는 childCoordinator에서 rootViewController 변수를 이용해 window를 초기화 해주어도 됩니다.
    /*
    func start() {
        let mainCoordinator = MainCoordinatorNavigation()
        window?.rootViewController = mainCoordinator.rootViewController
        self.childCoordinator = [mainCoordinator]
        mainCoordinator.start()
        window?.makeKeyAndVisible()
    }
     */
}
```

### Main Coordinator (or Content Coordintor) 
앱의 메인 흐름을 담당하는 코디네이터 입니다.  
navigation contoller, tab bar controller 가 대표적이겠죠  

### in Navigation Controller 
```swift
import UIKit

class MainCoordinatorNavigation: Coordinator {
    var rootViewController = UINavigationController()

    func start() {
        let vc = ViewController() 
        rootViewController.viewControllers = [vc]
    }
}
```

### in Tab bar Controller
```swift
import UIKit

class MainCoordinatorTabBar: Coordinator {
    var rootViewController = UITabBarController()

    func start() {

        // 각 VC에서 세부적으로 네비게이션이든지 뷰의 흐름이 있다면
        // Coordinator로 컨트롤 하면 됩니다.
        let firstVC = ViewController()
        firstVC.tabBarItem = UITabBarItem(title: "1번", image: nil, tag: 1)

        let secondVC = ViewController2()
        secondVC.tabBarItem = UITabBarItem(title: "2번", image: nil, tag: 2)


        self.rootViewController.viewControllers = [firstVC, secondVC]
    }
}
```

### in ChildViewController
참고할 만한 레퍼런스를 찾지못해 일단 한번 만들어 보았습니다. 

```swift
class MainCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    var nowVC: MainViewController?

    func setSub1ViewController() {
        self.nowVC!.childVC = Sub1ViewController()
        self.nowVC!.configureChildVC()
    }
    func setSub2ViewController() {
        self.nowVC!.childVC = Sub2ViewController()
        self.nowVC!.configureChildVC()
    }

    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        self.nowVC = vc
        self.rootViewController.viewControllers = [vc]
    }
}
```
코디네이터에서 mainVC에 접근하기위해 멤버변수로 초기화를 하였습니다. 
mainVC에서 target/action이 이루어지면 코디네이터의 함수를 실행하고
mainVC의 childVC변수를 선택한 vc로 초기화하고 컨테이너뷰(mainVC)에 추가하고 오토레이아웃을 다시 잡아줍니다. 
(초기화해야해서 다시 잡아줘야하는 것 같은데. 잘 모르겠습니다..)

```swift
// in MainViewController
func configureChildVC() {
    addChild(childVC)
    view.addSubview(childVC.view)
    childVC.didMove(toParent: self)

    childVC.view.topAnchor.constraint(equalTo: sub2Button.bottomAnchor).isActive = true
    childVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    childVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    childVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
}
```

[stackoverflow post](https://stackoverflow.com/questions/53818544/cannot-switch-to-another-child-view-controller-in-container-view) 를 참고하여 내부에서 해결하도록 구성해도 좋을듯 싶다. 


# Child Coordinator 

앱의 규모가 더 커진다면 다양한 흐름으로 구분지을 수 있을 것 이고 이를 차일드 코디네이터로 책임을 줄수 있습니다.  
이로서 더욱 쉽게 작업을 할 수 있고, 재사용가능한 디자인으로 설계할 수 있게 됩니다.  

### remove child
부모 코디네이터는 배열, 딕셔너리와 같은 변수를 가져 차일드 코디네이터를 관리합니다. 
자식 코디네터는 부모에게 자신이 종료 될때 알립니다. 이에 부모는 자식코디네이터를 찾아 remove합니다.  

```swift
// in child
func finishCoordinator() {
    parentCoordinator?.childDidFinish(self)
}
```
```swift
// in parent

func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated()
           // 같은 클래스를 참조하는지 비교하는것 이기에 참조연산자인 === 사용, coordinator 프로토콜, coordinator가 AnyObject(클래스임을) 프로토콜을 채택하여 비교가능 
        if coordinator === child {  
            childCoordinators.remove(at: index)
            return
        }
    } 
}
```
흐름이 단일 뷰라면 단순히 didDismissed 될때 실행하면 될탠데, 여러 단계가 있다면 관리가 쉽지 않을 것입니다. (단순히 뒤로가는 경우 등. )


### pop ChildCoordinator in navigation controller

이때는 네비게이션컨트롤러의 델리게이트를 이용할 수 있습니다. 

델리게이트의 didShow 메소드를 사용하여 네비게이션 이동간에 이전뷰(from)을 확인하고 child에서 parent 단게로 돌아오는 특정단계를 체크해 child를 제거합니다. 

```swift
import UIKit

class ParentCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // ParentCoordinator 흐름을 제어할 메서드들 정의
    // ex
    /*
    func showLogin() {
        // vc 초기화
        // navigation push
    }
     */

    func goChild() {
        let child = ChildCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                return
            }
        }
    }

    func start() {
        let vc = ParentViewController()
        vc.coordinator = self
        navigationController.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }

}


extension ParentCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        // 이전뷰(from)
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // fromVC가 포함됨: push 흐름이 진행중인 상태 -> return
        // 포함안됨 : pop
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // fromVC가 childCoordinator의 VC라면 childCoordinator의 흐름이 종료된 것 제거
        if let childVC = fromViewController as? ChildViewController {
            childDidFinish(childVC.coordinator)
        }
    }
}

```
```swift
import UIKit

class ChildCoordinator: Coordinator {
    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func finishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }

    func start() {
        let vc = ChildViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
```
