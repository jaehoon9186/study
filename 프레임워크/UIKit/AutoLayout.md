# * safeAreaLayoutGuide
세이프 에어리어를 기준으로 오토레이이아웃을 잡아보자. 앵커를 가이드에
```swift
func configureSuperUI() {
        let guide = view.safeAreaLayoutGuide
}
```


# * translatesAutoresizingMaskIntoConstraints = false
코드 베이스로 오토레이아웃을 잡을땐 항상 ```translatesAutoresizingMaskIntoConstraints = false```를 작성해 준다. 왜 일까??  

[docs](https://developer.apple.com/documentation/uikit/uiview/1622572-translatesautoresizingmaskintoco)  

<img width="818" alt="스크린샷 2023-07-27 오후 6 49 27" src="https://github.com/jaehoon9186/study/assets/83233720/bfd4e09a-1ce1-442b-8e6f-b18bd153ec2f">  

autoresizing mask가 Auto Layout constraints로 변환되는지 아닐껀지 결정.  

> ### autoresizing mask 가 머임 ? 
> [docs](https://developer.apple.com/documentation/uikit/uiview/1622559-autoresizingmask)  
> An integer bit mask that determines how the receiver resizes itself when its superview’s bounds change.  
> When a view’s bounds change, that view automatically resizes its subviews according to each subview’s autoresizing mask. ...  
> 슈퍼뷰의 바운드가 변경되면 서브뷰의 autoresizing mask를 통해 서브뷰의 크기를 조정한다.
>  
> 자동으로 UIView의 layout을 변경하는 방법 중 하나.  
> flexibleWidth, flexibleRightMargin 등의 프로퍼티가 추가될 수 있으며 이를 기반으로 슈퍼뷰의 바운드가 변경되면 따라 변경된다.

```If this property’s value is true, the system creates a set of constraints that duplicate the behavior specified by the view’s autoresizing mask.```  
translatesAutoresizingMaskIntoConstraints이 true인 경우. 해당 뷰의 autoresizing mask에 속하는 얘들을 Constraint 집합으로 복제한다.  
(코드베이스로 만들게 되는경우 자동으로 true로 설정됨.)  
따라서 Constraint를 추가할 수 없다. 
  
이러한 변경을 막기 위해 false로 설정한다.  
  
스토리보드에서는 Auto Layout을 적용하면 해당뷰는 자동으로 false로 된다.



