## STACK VIEW
UIView 컴포넌트들을 스택뷰에 추가하여 UI구성을 이지하게~

ex) 


### CODE
```swift
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

```
```swift
    // MARK: - Helpers
    func configureUI() {
        let guide = view.safeAreaLayoutGuide

        view.backgroundColor = .white
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)

        stackView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        // stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        button1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        ...
        ...
        
    }
```

## SCREENSHOT



https://github.com/jaehoon9186/study/assets/83233720/b99700f7-dd70-47e6-8177-ddbc90366242

