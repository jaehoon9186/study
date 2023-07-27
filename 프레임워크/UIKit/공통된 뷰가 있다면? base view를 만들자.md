# 공통된 뷰가 있다면? base view를 만들자

클래스의 특성을 활용해서 공통으로 적용할 부분을 슈퍼클래스로 정의하고 서브클래스들은 상속을 받아 구현함. 

<img width="300" alt="스크린샷 2023-07-27 오후 12 51 00" src="https://github.com/jaehoon9186/study/assets/83233720/6394247a-d9b9-4008-8a7b-ca9c659f1100">

```swift

import UIKit

class SuperViewController: UIViewController {

    let superViewTitle: UILabel = {
        let label = UILabel()
        label.text = "Super VIEW !"
        label.font = .systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSuperUI()
    }

    // subclass에서 overriding을 막기위해 final 키워드로 제한했음.
    final func configureSuperUI() {
        let guide = view.safeAreaLayoutGuide

        view.addSubview(superViewTitle)

        superViewTitle.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
        superViewTitle.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true

    }


}


```
```swift
import UIKit

class SubViewController: SuperViewController {

    let subViewTitle: UILabel = {
        let label = UILabel()
        label.text = "sub SUB sub SUB"
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Actions

    // MARK: - Helpers
    func configureUI() {
        let guide = view.safeAreaLayoutGuide

        view.addSubview(subViewTitle)
        subViewTitle.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        subViewTitle.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    }



}

```
