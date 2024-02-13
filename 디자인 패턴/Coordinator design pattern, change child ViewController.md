# Coordinator design pattern, change child ViewController

MainViewController.view 안에 여러개의 VC로 변환가능한 Child VC갖는 경우를 고민해 보았습니다.   

처음엔 MainVC에서 각 View의 isHidden? 인가를 활용하여 구분해 주었으나.   
코드가 길어지고, Coordinator를 사용함으로서 얻는 장점인 독립적인 View를 구성하는것과 맞지 않다고 생각해서.   

subview를 변환하는 것 또한 Coordinator에서 컨트롤 할수있도록 하였습니다.  


```swift
// SearchViewController
// ..
weak var coordinator: MainCoordinator?

var currentSubViewController: UIViewController? {
    didSet {
        removePreviousSubViewController()
        if let newSubViewController = currentSubViewController {
            addChild(newSubViewController)
            view.addSubview(newSubViewController.view)
            newSubViewController.didMove(toParent: self)

            newSubViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newSubViewController.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
                newSubViewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                newSubViewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                newSubViewController.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
        }
    }
}

private func removePreviousSubViewController() {
    currentSubViewController?.willMove(toParent: nil)
    currentSubViewController?.view.removeFromSuperview()
    currentSubViewController?.removeFromParent()
}

// ..
```


```swift
// Coordinator
// ..

var navigationController: UINavigationController?

func showSubViewController(scopeIndex: Int? = nil, searchText: String? = nil, isEdting: Bool) {
    guard let searchVC = navigationController?.topViewController as? SearchViewController else {
        return
    }

    var nextSubViewController: UIViewController

    if isEdting == true {
        let suggestionVC = SuggestionViewController()
        let viewModel = SuggestionViewModel()
        suggestionVC.delegate = searchVC
        suggestionVC.viewModel = viewModel
        nextSubViewController = suggestionVC
    } else {
        guard let scopeIndex = scopeIndex, let searchText = searchText else {
            return
        }

        switch scopeIndex {
        case 0:
            let webResultVC = WebResultViewController()
            let viewModel = WebResultViewModel()
            webResultVC.delegate = searchVC
            webResultVC.viewModel = viewModel
            webResultVC.searchWebSubject.send(searchText)
            nextSubViewController = webResultVC
        case 1:
            let imageResultVC = ImageResultViewController()
            let viewModel = ImageResultViewModel()
            imageResultVC.delegate = searchVC
            imageResultVC.viewModel = viewModel
            imageResultVC.searchImageSubject.send(searchText)
            nextSubViewController = imageResultVC
        case 2:
            let videoResultVC = VideoResultViewController()
            let viewModel = VideoResultViewModel()
            videoResultVC.delegate = searchVC
            videoResultVC.viewModel = viewModel
            videoResultVC.searchVideoSubject.send(searchText)
            nextSubViewController = videoResultVC
        default:
            return
        }
    }

    searchVC.currentSubViewController = nextSubViewController
}

func start() {
    let vc = SearchViewController()
    vc.coordinator = self

    let searchHomeVC = SearchHomeViewController()
    vc.currentSubViewController = searchHomeVC
    
    self.navigationController?.viewControllers = [vc]
}

// ..
```


