# MVVM, input-output.md

<img width="700" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b8ef40ad-296b-42a5-8bd3-0d5af2a18b59">


View와 ViewModel사이 Input, Output을 정의합니다. 

* 구조화 함으로 이벤트흐름을 파악하기 쉽다.(가독성 )
* 비동기처리를 간단하게 작업가능, 여러 퍼블리셔를 결합하기도 용의하다고함.

rxSwfit MVVM에 많이 사용된 패턴같은데..  


### 참고 
- [Youtube / Kelvin Fok / MVVM Combine Swift (2022) | UIKit | Transform Input & Output](https://www.youtube.com/watch?v=KK6ryBmTKHg&t=2089s)
- [Blog Post / [UIKit] MVVM Input-Output 패턴 사용에 대한 고찰 (with Combine)](https://www.heon.dev/swift/mvvm-input-output-pattern)
- [github post](https://github.com/YoonAh-dev/ImageExample_Pattern/blob/main/ImageExample_MVVM_Combine/ImageExample_MVVM_Combine/ViewModel/ViewModel.swift)
- [강남언니 공식 블로그 포스트 / MVVM + RxSwift iOS 프로젝트 ViewModel 테스트 하기](https://blog.gangnamunni.com/post/HealingPaperTV-ViewModel-Test/)

# 흐름 

Input과 Output을 정의합니다. 각각 Input은 유저액션을, Output은 반환값(결과)를 정의 합니다.  
View에서는 Output을 subscribe하고, ViewModel에서는 Input을 Subscribe합니다. 양방향으로 바인딩하여 비동기로 수행.  

1. View에서 이벤트 발생. 버튼 누르기 등(input send)
2. ViewModel에서 이벤트(Input)에 대한 비지니스 로직 수행
3. Output send
4. output에 맞춰 view update


# 적용경험
- [개인 프로젝트 / SearchAPP](https://github.com/jaehoon9186/SearchAPP) 

# 예제 
강남언니 블로그에 있는 rxSwift로 작성된 예제를 Combine으로 만들어 보았습니다.   
<img width="200" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/5fa44ce1-49d1-41aa-b702-9ab59d0350ae">


### protocol
```swift
protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
```

### ViewModel
```swift
import UIKit
import Combine

class CountViewModel: ViewModelType {
    struct Input {
        var plusAction: AnyPublisher<Void, Never>
        var subtractAction: AnyPublisher<Void, Never>
    }

    struct Output {
        var countedValue: AnyPublisher<Int, Never>
    }

    private var cancellable = Set<AnyCancellable>()

    // output

    func transform(input: Input) -> Output {
        // output
        let countedValue: CurrentValueSubject<Int, Never> = .init(1)

        input.plusAction.sink { _ in
            countedValue.send(countedValue.value + 1)
        }.store(in: &cancellable)

        input.subtractAction.sink { _ in
            countedValue.send(countedValue.value - 1)
        }.store(in: &cancellable)

        return Output(countedValue: countedValue.eraseToAnyPublisher())
    }
}
```

### View
```swift
import UIKit
import Combine

class CountViewContoller: UIViewController {

    var viewModel: CountViewModel!
    private var cancellable = Set<AnyCancellable>()

    // input
    private let plusSubject: PassthroughSubject<Void, Never> = .init()
    private let subtractSubject: PassthroughSubject<Void, Never> = .init()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tapPlusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var subtractButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tapSubtractButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureUI()
    }

    @objc
    private func tapPlusButton() {
        plusSubject.send()
    }

    @objc
    private func tapSubtractButton() {
        subtractSubject.send()
    }

    private func bind() {
        let input = CountViewModel.Input(
            plusAction: self.plusSubject.eraseToAnyPublisher(),
            subtractAction: self.subtractSubject.eraseToAnyPublisher()
        )

        let output = viewModel.transform(input: input)
        output.countedValue
            .map { String($0) }
            .sink { [weak self] count in
                self?.countLabel.text = count
            }
            .store(in: &cancellable)
    }

    private func configureUI() {
        self.view.backgroundColor = .white

        view.addSubview(countLabel)
        view.addSubview(plusButton)
        view.addSubview(subtractButton)

        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 50),
            countLabel.heightAnchor.constraint(equalToConstant: 50),

            plusButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 10),
            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),

            subtractButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -10),
            subtractButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            subtractButton.widthAnchor.constraint(equalToConstant: 50),
            subtractButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
```
