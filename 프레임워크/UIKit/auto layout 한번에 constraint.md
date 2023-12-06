# auto layout 한번에 constraint

```swift
NSLayoutConstraint.activate([
    controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
    controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
    controller.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
    controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
])
```
