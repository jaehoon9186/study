# MVVM Pattern CODE

## 파일 구조
<img width="262" alt="스크린샷 2023-06-09 오후 3 06 51" src="https://github.com/jaehoon9186/study/assets/83233720/9fff5636-10dc-4e3a-a864-b584a06b535b">

## 이미지
![Simulator Screen Recording - iPhone 14 Pro - 2023-06-09 at 15 08 51](https://github.com/jaehoon9186/study/assets/83233720/76d54283-fdc2-430b-af57-f090bcfaf56d)


## CODE

> ### Model
```swift
// MARK: - Model
struct MVVMAnimal {
    let icon: String

    init(icon: String) {
        self.icon = icon
    }
}
```

> ### View
```swift
import UIKit
import Combine

// MARK: - View
class MVVMAnimalViewController: UIViewController {
    // MARK: - Properties
    private let animalIconObserver: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 100)
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .cyan.withAlphaComponent(0.2)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 50
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()

    private let animalIconCombine: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 100)
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .purple.withAlphaComponent(0.2)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 50
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()

    private lazy var changeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("CHANGE", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive
         = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.addTarget(self, action: #selector(allIconChange), for: .touchUpInside)
        return button
    }()

    private var viewModel = MVVMViewModel()

    // 메모리 관리를 위해 취소를 자동으로 해주는 AnyCancellable 만들어 준다.
    // (뷰컨이 해제되면 자동으로 cancel() 실행)
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setBind()

    }

    // MARK: - Actions
    @objc private func allIconChange() {
        viewModel.showRandomAnimal()
    }

    // MARK: - Helpers
    func setBind() {
        viewModel.observerAnimal.bind { [unowned self] animal in
            self.animalIconObserver.text = animal.icon
        }

        viewModel.$combineAnimal.sink { [unowned self] animal in
            self.animalIconCombine.text = animal.icon
        }.store(in: &cancellables)
    }

    func configure() {
        self.view.backgroundColor = .white

        let guide = self.view.safeAreaLayoutGuide

        let stack = UIStackView(arrangedSubviews: [animalIconObserver, animalIconCombine, changeBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center

        self.view.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true

    }
}

```

> ### ViewModel
```swift
import Foundation
import Combine

// MARK: - ViewModel
class MVVMViewModel {
    var animals: [MVVMAnimal]?

    var observerAnimal: ObservableObject<MVVMAnimal> = ObservableObject(MVVMAnimal(icon: "옵저버 클래스 이용 바인딩"))

    // @Published 키워드를 통해 바인딩.
    // 접근할 때는 $ 키워드를 변수명 앞에 붙혀 접근함.
    @Published var combineAnimal: MVVMAnimal = MVVMAnimal(icon: "컴바인 이용 바인딩")

    init() {
        animals = MVVMService().getAllAnimals()
    }

    func showRandomAnimal() {
        if let animal = animals?.randomElement() {
            self.observerAnimal.value = animal
        }

        if let animal = animals?.randomElement() {
            self.combineAnimal = animal
        }
    }
}

```

> ### Etc
```swift
class ObservableObject<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
```

```swift
class MVVMService {
    func getAllAnimals() -> [MVVMAnimal] {
        let animals = [
            MVVMAnimal(icon: "🐯"), MVVMAnimal(icon: "🐥"), MVVMAnimal(icon: "🐸"), MVVMAnimal(icon: "🐶"), MVVMAnimal(icon: "🐼"), MVVMAnimal(icon: "🦊"), MVVMAnimal(icon: "🦁"), MVVMAnimal(icon: "🐰")
        ]
        return animals
    }
}
```
