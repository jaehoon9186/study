# safeAreaLayoutGuide
세이프 에어리어를 기준으로 오토레이이아웃을 잡아보자. 앵커를 가이드에
```swift
func configureSuperUI() {
        let guide = view.safeAreaLayoutGuide
}
```


# translatesAutoresizingMaskIntoConstraints = false
코드 베이스로 오토레이아웃을 잡을땐 항상 ```translatesAutoresizingMaskIntoConstraints = false```를 작성해 준다. 왜 일까??  

[docs](https://developer.apple.com/documentation/uikit/uiview/1622572-translatesautoresizingmaskintoco)  

<img width="818" alt="스크린샷 2023-07-27 오후 6 49 27" src="https://github.com/jaehoon9186/study/assets/83233720/bfd4e09a-1ce1-442b-8e6f-b18bd153ec2f">  

autoresizing mask가 Auto Layout constraints로 변환되는지 아닐껀지 결정.  

### autoresizing mask ? 

[docs](https://developer.apple.com/documentation/uikit/uiview/1622559-autoresizingmask)  


