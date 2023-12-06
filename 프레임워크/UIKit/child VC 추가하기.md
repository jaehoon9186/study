# child VC 추가하기

### 참고
* [How to add a Container View programmatically/ stackoverflow](https://stackoverflow.com/questions/37370801/how-to-add-a-container-view-programmatically)
* [blog post](https://ios-development.tistory.com/228)

# 순서
1. ```addChild``` 부모뷰에 차일드 VC 인스턴스 추가
2. ```addSubview``` chlidVC.view 를 추가
3. ```didMove(toParent:)``` childVC에게 시점을 알려주기 위함. didMove는 추가된 후
4. 오토레이아웃

해제 될 때는  
1. ```willMove(toParent:)``` 해제되기 전 호출
2. ```removeFromParent``` 관계삭제
3. ```부모.view.removeFromSuperView``` addSubview와 반대

# 코드
```swift
func configureChildVC() {
    addChild(childVC)
    view.addSubview(childVC.view)
    childVC.didMove(toParent: self)

    childVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    childVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    childVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    childVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
}
```
