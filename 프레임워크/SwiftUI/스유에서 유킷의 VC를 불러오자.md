# 스유에서 유킷의 VC를 불러오자.

- [https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable)
- [https://developer.apple.com/documentation/swiftui/uiviewrepresentable](https://developer.apple.com/documentation/swiftui/uiviewrepresentable)

- [https://tanaschita.com/20230508-coordinators-in-swiftui/](https://tanaschita.com/20230508-coordinators-in-swiftui/)
- [https://www.youtube.com/watch?v=wqa1hCu8yCI](https://www.youtube.com/watch?v=wqa1hCu8yCI)
- [https://www.hackingwithswift.com/books/ios-swiftui/using-coordinators-to-manage-swiftui-view-controllers](https://www.hackingwithswift.com/books/ios-swiftui/using-coordinators-to-manage-swiftui-view-controllers)


#

VC는 UIViewControllerRepresentable 프로토콜을.  
UIView는 UIViewRepresentable 프로토콜을 사용함.  


UIViewControllerRepresentable 만 일단 사용해보겠음.  

목표는 
```
[Parent]           [Child]
SwiftUI             UIKit           
View         <->   UIViewController  
ViewModel 1        ViewModel 2
```  

VM1,2 가 동일한 프로퍼티를 공유할 수 있도록 하고싶었고,  
추가로 유킷에서도 컴바인을 사용해 반응형으로 구성할 예정임.  


스유에서 유아이킷 띄우는거니 parent, child 라 명명했음. 

# 


<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/03f288f4-4113-4614-9cda-075e1db1a75b">
</p>


```swift
import SwiftUI

/*

    SwiftUI View

*/

@Observable
class ParentViewModel {
    var number: Int = 0
    func addButtonTapped() { number += 1 }
    func minusButtonTapped() { number -= 1 }
}

struct ParentView: View {
    @State var viewModel = ParentViewModel()

    var body: some View {
        VStack {

            VStack {
                Text("ParentView's viewModel, number: \(viewModel.number)")
                HStack {
                    Button("+") { viewModel.addButtonTapped() }
                    Button("-") { viewModel.minusButtonTapped() }
                }
            }
            .frame(width: 400, height: 100)
            .border(.blue)

            Group {
                ChildView(parentNum: $viewModel.number)
            }
            .frame(width: 400, height: 100)
            .border(.red)
        }
    }
}

#Preview {
    ParentView()
}

```


```swift
import UIKit
import SwiftUI
import Combine

/*
    
    UIViewControllerRepresentable

*/

// UIViewController
struct ChildView: UIViewControllerRepresentable {
    @Binding var parentNum: Int

    // 리턴 타입 수정했음. 원래 some VC
    func makeUIViewController(context: Context) -> ChildViewController {
        let vm = ChildViewModel(number: parentNum)

        let vc = ChildViewController()
        vc.viewModel = vm
        vc.delegate = context.coordinator

        return vc
    }

    // SwiftUI to UIKit
    // 매개변수의 타입을 구체적인 타입으로 수정했음. 안하려면 타입캐스팅 ㄱ
    func updateUIViewController(_ uiViewController: ChildViewController, context: Context) {
        uiViewController.viewModel?.updateNumberFromParent(newNumber: parentNum)
    }

    // UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(parentNum: $parentNum)
    }

    class Coordinator: NSObject, ChildViewControllerDelegate {
        @Binding var coordinatorNum: Int

        init(parentNum: Binding<Int>) {
            self._coordinatorNum = parentNum
        }

        func didUpdateNumber(_ ChildNum: Int) {
            coordinatorNum = ChildNum
        }
    }
}


/*

    ViewContoller, ViewModel

*/

protocol ChildViewControllerDelegate: NSObject {
    func didUpdateNumber(_ ChildNum: Int) // child to parent
}

class ChildViewController: UIViewController {
    // MARK: - Properties

    var viewModel: ChildViewModel?

    private var cancellables = Set<AnyCancellable>()

    weak var delegate: ChildViewControllerDelegate? // *

    private var text: UILabel = {
        let label = UILabel()
        label.text = "ChildviewController's viewModel's number: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var num: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var plusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var minusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bind()
    }

    private func bind() {
        viewModel?.number
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] num in
                self?.num.text = String(num) // View 변경
                self?.delegate?.didUpdateNumber(num) // delegate로 코디네이터를 거쳐 스유에 방출 *
            })
            .store(in: &cancellables)
    }

    // MARK: - Actions
    @objc
    private func plusButtonTapped() { viewModel?.addButtonTapped() }

    @objc
    private func minusButtonTapped() { viewModel?.minusButtonTapped() }

    // MARK: - Helpers
    private func configureUI() {
        view.addSubview(text)
        view.addSubview(num)
        view.addSubview(plusButton)
        view.addSubview(minusButton)

        text.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        num.leadingAnchor.constraint(equalTo: text.trailingAnchor, constant: 10).isActive = true
        num.centerYAnchor.constraint(equalTo: text.centerYAnchor).isActive = true

        plusButton.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: text.centerXAnchor, constant: -10).isActive = true

        minusButton.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10).isActive = true
        minusButton.centerXAnchor.constraint(equalTo: text.centerXAnchor, constant: 10).isActive = true
    }
}


class ChildViewModel {
    var number = CurrentValueSubject<Int, Never>(0)

    init(number: Int) {
        self.number.send(number)
    }

    func addButtonTapped() {
        self.number.send(number.value + 1)
    }

    func minusButtonTapped() {
        self.number.send(number.value - 1)
    }

    // parent(SwiftUI) to child(UIKit)
    func updateNumberFromParent(newNumber: Int) {
        self.number.send(newNumber)
    }
}


```


