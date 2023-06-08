# MVP pattern CODE

## 파일 구조
<img width="226" alt="스크린샷 2023-06-05 오후 7 28 13" src="https://github.com/jaehoon9186/study/assets/83233720/495996e5-003a-4119-b02e-d7afcc9e0182">

## 이미지
버튼을 클릭하면 랜덤하게 동물 정보를 가져온다. 
![Simulator Screen Recording - iPhone 14 Pro - 2023-06-05 at 19 29 50](https://github.com/jaehoon9186/study/assets/83233720/83aebd64-eddc-476c-8d17-5ef9c6fc791a)


## CODE
> ### MODEL
```swift
// MARK: - Model
struct Animal {
    let iconImage: String
    let name: String

    init(iconImage: String, name: String) {
        self.iconImage = iconImage
        self.name = name
    }
}
```
> ### VIEW
```swift
// MARK: - View Protocol
protocol AnimalView: AnyObject {
    func setRandomAnimal(icon: String, name: String)
}


// MARK: - View
class AnimalViewController: UIViewController {

    // MARK: - Properties
    // UIButton, label 등 생략

    var presenter: AnimalViewPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // init으로 or 클래스 멤버 변수로
        presenter = AnimalPresenter(view: self)

        configureUI()
    }

    // MARK: - Actions
    @objc func touchRefreshButton() {
        presenter?.showRandomAnimal()
    }

    // MARK: - Helpers
    func configureUI() {
    // UI 구성 생략
    }
}

extension AnimalViewController: AnimalView {
    func setRandomAnimal(icon: String, name: String) {
        self.animalIcon.text = icon
        self.animalName.text = name
    }
}

```

> ### PRESENTER
```swift
// MARK: - Presenter Protocol
protocol AnimalViewPresenter {
    func showRandomAnimal()
}

// MARK: - Presenter
class AnimalPresenter {

    weak var animalView: AnimalView?
    
    // 모델 소유 해야함. 모델 인스턴스 만들자. 

    let service = Service()

    init(view: AnimalView) {
        self.animalView = view
    }
}

extension AnimalPresenter: AnimalViewPresenter {
    func showRandomAnimal() {
        if let animal = service.randomAnimal() {
            DispatchQueue.main.async {
                self.animalView?.setRandomAnimal(icon: animal.iconImage, name: animal.name)
            }
        }
    }
}

```

> ### 기타 
정보를 가져오는 Service() 클래스를 만들어서 사용했다. 
여러뷰에서 사용될 공통 클래스들?
API 싱글톤 글래스, CoreData 등
```swift
// MARK: - Service
class Service {
    var list = [Animal]()

    init() {
        self.list = allAnimalList()
    }

    func allAnimalList() -> [Animal] {
        let list: [Animal] = [
            Animal(iconImage: "🐯", name: "호랑이"),
            Animal(iconImage: "🐥", name: "병아리"),
            Animal(iconImage: "🐶", name: "강아지"),
            Animal(iconImage: "🐼", name: "판다"),
            Animal(iconImage: "🐱", name: "고양이")
        ]

        return list
    }

    func randomAnimal() -> Animal? {
        return list.randomElement()
    }
}
```
