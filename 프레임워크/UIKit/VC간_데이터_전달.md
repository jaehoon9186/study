
## View Controller 간 데이터 전달
A. 직접 데이터를 전달하는 방법도 있고.  
B. 공통된 데이터에 접근해서 각 VC에서 데이터를 사용하는 방법이 있다.  
  
먼저 A 방법들을 알아보자.   

### 1. VC Class의 맴버 변수를 변경해서 새로운 VC를 띄운다.
navication push/pop 또는 modal present할 경우.
> SCREENSHOT
<img src="https://github.com/jaehoon9186/study/assets/83233720/0a6b7e4b-2769-49d5-b68f-a6f3e7ce8f80" width="150" />


> CODE
```swift
// first VC, push
    @objc func goNavigationView() {
        let vc = NaviViewController()
        vc.string = self.label.text // 🐸
        self.navigationController?.pushViewController(vc, animated: true)
    }
```
```swift
// Second VC, pop
class NaviViewController: UIViewController {
    // MARK: - Properties
    var string: String?
    
    ...
    
    
    // First View로 데이터 전송할 때. 
    @objc func toHome() {
        guard let vc = self.navigationController?.viewControllers[0] as? TestViewController else {
            return
        }
       
        vc.label.text = "🐯"
        navigationController?.popViewController(animated: true)
    }
    
    ...
}

```

### 2. 생성자 이용 전달.
스샷은 생략

> CODE
```swift
// first VC
    @objc func goSecondView() {
        let vc = SecondViewController(secondVCStr: "전달")
        self.present(vc, animated: true)
    }

```
```swift
// Second VC
class SecondViewController: UIViewController {
    // MARK: - Properties
    var secondVCStr: String?
    
    ...

    // MARK: - Lifecycle
    init(secondVCStr: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.secondVCStr = secondVCStr
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ...
}

```

### 3. Delegate Pattern 이용 전달
FirstVC(TestViewController) <-> SecondVC(SecondViewController)  
SecondVC의 변수 delegate를 FirstVC에 위임.  
SecondVC의 delegate에 무슨일이 생기면 FirstVC가 처리한다!!  

예제)  
FirstVC -> SecondVC : SecondVC에서 FirstVC의 동물아이콘을 가져온다.  
FirstVC <- SecondVC : SecondVC에서 FirstVC로 넘어갈때 랜덤으로 동물 아이콘을 변경한다.  



> SCREENSHOT
<img src="https://github.com/jaehoon9186/study/assets/83233720/79fe71cb-5a59-4037-9307-39e134327e5e" width="150" />

> CODE

```swift
// delegate
protocol DataDelegate {
    func passingString(string: String)
    func getString() -> String
}

```

```swift
// firstVC
// delegate를 채택, 준수
// SecondVC를 생성후 위임자를 지정해준다. 

class TestViewController: UIViewController {
    ...

    @objc func goSecondVC() {
        let vc = SecondViewcontroller()
        vc.modalPresentationStyle = .fullScreen
        
        // VC의 dataDelegete를 내가(TestViewController) 대신할게~~
        vc.dataDelegete = self
        self.present(vc, animated: true)

    }
    
    ...
}

extension TestViewController: DataDelegate {
    func getString() -> String {
        return self.label.text ?? "nil"
    }
    func passingString(string: String) {
        self.label.text = string
    }
}

```
```swift
// SecondVC
// Delegate에 의해 만들어진 Func(FirstVC의)을 SecondVC에서 실행한다. 

class SecondViewcontroller: UIViewController {

    var dataDelegete: DataDelegate?
    
    ...
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let str = dataDelegete?.getString() {
            button.setTitle("\(str) 넘어옴", for: .normal)
        }
        configureUI()
    }
    
    @objc func toHome() {
        let randomAnimal: [String] = ["🐯", "🐸", "🦁", "🐶", "🐹", "🦊", "🐥"]
        if let animal = randomAnimal.randomElement() {
            dataDelegete?.passingString(string: animal)
        }
        self.presentingViewController?.dismiss(animated: true)
    }
    
    ...
}

```

### 4. Closure 이용 전달 
FirstVC <-> SecondVC 로 데이터 전달을 하고싶을때  

미리 Call Back 함수를 정의 
  
> CODE

```swift
// FirstVC
class TestViewController: UIViewController {
    ...
    
    @objc func goSecondVC() {
        let vc = SecondViewcontroller()
        
        vc.completion = { (string) -> Void in
            self.label.text = string
        }
        vc.getCompletion = {
            return self.label.text ?? "nil!!"
        }
        self.present(vc, animated: true)
    }
    
    ...
}

```
```swift
// SecondVC
class SecondViewcontroller: UIViewController {
    
    // SecondVC 에서 FirstVC로 전달할 때
    var completion: ((String)->(Void))?

    // SecondVC 에서 FirstVC에 Data를 가져올 때
    var getCompletion: (() -> String)?
    
    // both VC간에 callback함수를 하나로 할 수도 있을 것 같은데 ..
    
    ...
    override func viewDidLoad() {
        super.viewDidLoad()

        if let getAnimal = getCompletion?() {
            self.button.setTitle(getAnimal, for: .normal)
        }

        configureUI()
    }
    
    @objc func toHome() {
        let randomAnimal: [String] = ["🐯", "🐸", "🦁", "🐶", "🐹", "🦊", "🐥"]

        if let animal = randomAnimal.randomElement() {
            completion?(animal)
        }

        self.presentingViewController?.dismiss(animated: true)
    }
    
    ...
}

```


### 5. NotificationCenter 이용 전달
~~나중에 다시..~~
A notification dispatch mechanism that enables the broadcast of information to registered observers.  

옵져버 : ~한 정보가 오면 알려줘라~

주요 세개 컴포넌트  
- Notification Observing
- Notification Sending
- Respond to Notification
- 

> CODE
```swift
```

```swift
```





