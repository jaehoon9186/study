# Coordinator design pattern 3 MVVM-C, self-deallocated

MVVM 아키텍처 패턴과 함께 적용을 합니다. 
child Coordinator 단계에서 탈출시 자체적으로 deallocated 할 수 있도록 고민해 보았습니다. 

### 참고 
* [Self-deallocated Coordinator pattern in Swift/ medium post](https://medium.com/vptech/coordinator-pattern-in-swift-without-child-coordinators-42d482d15975)

# 기존 방식의 문제점 

기존에 알려진 방식으로는 부모코디네이터에서는 자식코디네이터를 배열에 저장하고 자식코디네이터의 흐름이 마쳐지면 배열에서 찾아 제거하는 흐름입니다.  
자식 코디네이터의 흐름으로 여러개의 VIEW를 거치게 된다면 어떤 VIEW에서 스와이프, 또는 뒤로버튼을 이용하는지 navigationContollerDelegate를 이용해 흐름을 관찰하고 제거하게 되는데.  
이는 ```popToRootViewController(animated:)```, ```popToViewController(_:animated:)``` 등의 함수 이용에 제한이 되고, 또한 하나하나 비교한다는 것이 번거롭다고 느껴졌습니다. 
(기존방식에서의 예제는 참고링크를 통해 볼 수 있습니다. ) 

따라서, navigationContollerDelegate를 이용하지 않고 **ARC**(automatic reference counting)만을 이용하여 자식 코디네이터를 deinit 하도록 구현하였습니다. 

참고링크의 작성자는 1:1(VM:View)관계로 구성하였으나, MVVM은 1:N(VM:View)으로 구성할 수 있어야 하는것으로 알고 있어서 참고된 글과는 다르게 구성해 보았습니다. (이 방법이 맞는지는 확신없음.. )  

# 뷰 흐름도 
<img width="990" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/f72bb115-2451-4094-959f-11df57fd5c73">

예시로 메인흐름 중 회원가입흐름(Register Coordinator)단계로 진행하는 과정을 표현해 보았습니다.  


# deallocated 단계별 설명
<img width="883" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/2964b7e5-3341-4034-8adf-14abe96cb55f">

화살표 실선은 강한참조(strong)를, 화살표 점선은 약한참조(weak)를 나타냅니다.  
번호는 단계가 전부 진행된 후 메모리에서 할당 해제 되는 순서입니다.  

1. Register Coordinator의 navigation이 두개의 VC를 pop합니다.
    : VC(RegisterStepOneVC, RegisterStepTwoVC)의 rc(reference count)가 0이 되어 deallocate 됩니다. 
2. VC가 할당해제됩에 따라 ViewModel의 rc도 0이 되어 deallocate 됩니다.
3. Register Coordinator가 ViewModel을 약한 참조 하였기에 2번 단계에서 ViewModel이 할당해제 될 수 있습니다.
4. RegisterCoordinator도 deallocate 됩니다. 

* ViewModel은

# 이미지 
![화면 기록 2023-12-08 오전 2 22 39](https://github.com/jaehoon9186/study/assets/83233720/02586b87-13cf-4f8d-80ac-b0dcf88e381a)


# 코드 
- [프로젝트]()

### protocol
```swift
protocol Coordinator: AnyObject {
    func start()
}
```

### MainCoordinator
```swift
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?
    weak var childCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("main coordi deinit")
    }

    func start() {
        let vc = MainViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }

}

extension MainCoordinator: MainViewControllerDelegate {
    func goRegister() {
        let registerVM = RegisterViewModel()
        let child = RegisterCoordinator(navigationController: navigationController, viewModel: registerVM)
        child.parentCoordinator = self
        self.childCoordinator = child
        child.start()
    }
}
```

### MainView
```swift
import UIKit

protocol MainViewControllerDelegate {
    func goRegister()
}

class MainViewController: UIViewController {
    // MARK: - Properties
    var delegate: MainViewControllerDelegate?

    private lazy var contentStack: UIStackView = {
        // 생략
    }()

    private lazy var registerButton: UIButton = {
        // 생략
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Actions
    @objc private func goRegisterFlow() {
        delegate?.goRegister()
    }

    // MARK: - Helpers
    func configureUI() {
        // 생략
    }
}

```

### RegisterCoordinator
```swift
import UIKit

class RegisterCoordinator: Coordinator {

    var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController?
    weak var viewModel: RegisterViewModel?

    init(navigationController: UINavigationController?, viewModel: RegisterViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.viewModel?.delegate = self

        print("init - RegisterCoordinator")
    }

    deinit {
        print("deinit - RegisterCoordinator")
    }

    func start() {
        let vc = RegisterStepOneViewController()
        vc.vm = self.viewModel
        vc.delegate = self.viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterCoordinator: RegisterViewModelDelegate {
    func showRegisterStepTwoVC() {
        let vc = RegisterStepTwoViewController()
        vc.vm = self.viewModel
        vc.delegate = self.viewModel
        navigationController?.pushViewController(vc, animated: true)
    }

    func toParent() {
        for vc in navigationController!.viewControllers {
            if vc is MainViewController {
                navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
}
```

### RegisterViewModel
```swift
import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func showRegisterStepTwoVC()
    func toParent()
}

class RegisterViewModel {
    var delegate: RegisterViewModelDelegate?

    init() {
        print("init - ViewModel")
    }
    deinit {
        print("deinit - ViewModel")
    }
}

extension RegisterViewModel: RegisterStepOneViewControllerDelegate {
    func showRegisterStepTwoVC() {
        self.delegate?.showRegisterStepTwoVC()
    }
}
extension RegisterViewModel: RegisterStepTwoViewControllerDelegate {
    func toParent() {
        self.delegate?.toParent()
    }
}
```

### RegisterView
```swift
import UIKit

protocol RegisterStepOneViewControllerDelegate: AnyObject {
    func showRegisterStepTwoVC()
}

class RegisterStepOneViewController: UIViewController {
    // MARK: - Properties
    var delegate: RegisterStepOneViewControllerDelegate?
    var vm: RegisterViewModel?

    lazy var toStepTwoButton: UIButton = {
        // 생략
    }()

    lazy var contentStack: UIStackView = {
        // 생략
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("init - 1vc RegisterStepOneVC")
    }

    deinit {
        print("deinit - 1vc RegisterStepOneVC")
    }

    // MARK: - Actions
    @objc func tapToStepTwoButton() {
        delegate?.showRegisterStepTwoVC()
    }

    // MARK: - Helpers
    func configureUI() {
        // 생략
    }
}
```

```swift
import UIKit

protocol RegisterStepTwoViewControllerDelegate: AnyObject {
    func toParent()
}

class RegisterStepTwoViewController: UIViewController {
    // MARK: - Properties
    var delegate: RegisterStepTwoViewControllerDelegate?
    var vm: RegisterViewModel?

    lazy var toMainVCButton: UIButton = {
        // 생략
    }()

    lazy var contentStack: UIStackView = {
        // 생략
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("init - 2vc RegisterStepTwoVC")
    }

    deinit {
        print("deinit - 2vc RegisterStepTwoVC")
    }

    // MARK: - Actions
    @objc func tapToMainVCButton() {
        delegate?.toParent()
    }

    // MARK: - Helpers
    func configureUI() {
        // 생략
    }

}
```
