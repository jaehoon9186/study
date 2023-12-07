# navigation controller에서 원하는 VC로 pop

```swift
for vc in navigationController.viewControllers {
    if vc is FirstViewController {
        navigationController.popToViewController(vc, animated: true)
    }
}
```
