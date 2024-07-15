# TCA
- [https://velog.io/@flamozzi/SwiftUI-MVVM%EC%9D%98-%EB%8C%80%ED%95%9C-%EA%B3%A0%EC%B0%B0](https://velog.io/@flamozzi/SwiftUI-MVVM%EC%9D%98-%EB%8C%80%ED%95%9C-%EA%B3%A0%EC%B0%B0)
- 

# SwfitUI에서 MVVM의 필요성? 

먼저.. 

```
간단히

imperative(명령형)     vs     declarative(선언형)
HOW?                         WHAT?

i.g. 너네 집에 어떻게가?
: 몇번 출구로 나와서             : **아파트로와
> 어디 마트쪽으로 코너 돌아
> 10000미터 직진 ...

i.g. 배열의 합
:배열을 for 루프로              : reduce 고차함수로 
계산해 반환

in swift, 
: UIKit                      : SwiftUI
user action                   user action
> model update                (변경된 State 를 기반으로 UI update)
> UI update
(변수, 이벤트)                   UI객체를 다시 생성
```

```
MVVM은 뭘 위해 개발 되었나?

UI(view), 비지니스 로직(viewModel)을 분리하기 위해 (복잡성을 줄여 유지보수용이, 테스터블)
Binding을 통해 UI 업데이트를 쉽게 (UIKit이 명령형 패러다임이라 필요했음.)
```

</br>
</br>

swiftUI는 선언형 프로그래밍 패러다임으로 @State, @Binding, @ObservedObject, @EnvironmentObject 등의 어트리뷰트를 제공하는데 이를 활용해 데이터 바인딩을 쉽고 직관적으로 처리 가능함.  

</br>
</br>

swiftUI에서 VM을 사용하는것이 문제는 없지만 
1. 꼭 필요하지 않다.  
  : 애초에 State 프로퍼티를 제공하는데 VM로 다시 바인딩할 필요가 없다.
2. 복잡성이 증가한다.  
  : 한단계를 더 거쳐야 하는 문제? 불필요한 레이어 추가

***-> swiftUI에서 MVVM은 불필요..***


</br>
</br>

그렇다면 어떤 아키텍쳐가 필요함?  
비지니스 로직은 분리하고자 함.  




또는..
- [environment 를 활용한 MVC 패턴 적용(youtube)](https://www.youtube.com/watch?v=2D05dGo3jB4&t=1s)  
이런 방법을 제시하는 것 같음.  



```
단방향 아키텍처?

```




# TCA?




