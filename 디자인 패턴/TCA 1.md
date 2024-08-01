# TCA
- [https://github.com/pointfreeco/swift-composable-architecture](https://github.com/pointfreeco/swift-composable-architecture)
- [https://gist.github.com/pilgwon/ea05e2207ab68bdd1f49dff97b293b17](https://gist.github.com/pilgwon/ea05e2207ab68bdd1f49dff97b293b17)
- [https://axiomatic-fuschia-666.notion.site/SwiftUI-iOS-TCA-1-0-596f01cfa306427ea47779406da676e1](https://axiomatic-fuschia-666.notion.site/SwiftUI-iOS-TCA-1-0-596f01cfa306427ea47779406da676e1)
- [https://velog.io/@flamozzi/SwiftUI-MVVM%EC%9D%98-%EB%8C%80%ED%95%9C-%EA%B3%A0%EC%B0%B0](https://velog.io/@flamozzi/SwiftUI-MVVM%EC%9D%98-%EB%8C%80%ED%95%9C-%EA%B3%A0%EC%B0%B0)
- [https://medium.com/@mooyoung2309/swiftui-tca-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-1-1d1c93a79dda](https://medium.com/@mooyoung2309/swiftui-tca-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-1-1d1c93a79dda)
- [https://www.theteams.kr/teams/2664/post/67906](https://www.theteams.kr/teams/2664/post/67906)

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

(원래는 스유에서도 MVVM 적용했는디, property wrapper가 발전됨에 따라 MVVM이 필수적이지 않아진 것)  


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

그렇다면 property wrapper로 vm을 대체 할 수 있나? [참고](https://doing-programming.tistory.com/entry/SwiftUI-%EC%97%90%EC%84%9C-MVVM-%EC%9D%84-%EB%A9%88%EC%B6%B0%EC%95%BC-%ED%95%98%EB%8A%94%EA%B0%80)
1. 수명주기가 View에 종속됨.
2. 


</br>
</br>

그렇다면 어떤 아키텍쳐를 적용?  
비지니스 로직은 분리하고자 함.  




또는..?  
- [environment 를 활용한 MVC 패턴 적용(youtube)](https://www.youtube.com/watch?v=2D05dGo3jB4&t=1s)    
이런 방법을 제시하는 것 같음.  



# TCA(The Composable Architecture) ? 

- [문서](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/)
- [https://axiomatic-fuschia-666.notion.site/SwiftUI-iOS-TCA-1-0-596f01cfa306427ea47779406da676e1](https://axiomatic-fuschia-666.notion.site/SwiftUI-iOS-TCA-1-0-596f01cfa306427ea47779406da676e1)
- [https://www.youtube.com/watch?v=McmGb9sexMo&list=PLHWvYoDHvsOVo4tklgLW1g7gy4Kmk4kjw&index=2](https://www.youtube.com/watch?v=McmGb9sexMo&list=PLHWvYoDHvsOVo4tklgLW1g7gy4Kmk4kjw&index=2)


사이드이펙트(부작용)이 적음. 왜? 단방향이기에  

상태를 기반으로  

다른 단방향 아키텍처인 Elm, Redux와 뭐가 다름? Combine 같은 swift 퍼스트 파티 라이브러리를 사용해 swift 에 맞게 만들어짐.(사용하기 그나마 익숙)    

SPM으로만 설치 가능함.  

State는 read-only  

단방향으로 흐름을 강제하기 때문에, 흐름을 이해하기 쉬워 유지보수 용이(반대로, 양방향 MVC는 다양한 패턴들이 파생되기도함.)  


SSOT(단일 진실 공급원, Single Source Of Truth)을 따를수 있음.  
하나의 정보(데이터)는 하나의 출처(저장소)에서만 생성, 관리 한다는 방법론. 
(
수정되는 것이 데이터의 흐름을 관리하고 유지보수할 때 이해하기 편하기 때문입니다.
우리가 어떤 데이터를 여러 곳에 분산해놓고서 이걸 여러 곳에서 다룬다고 합시다.
그럼 우리는 이 데이터가 어디서 오는지 일일이 추적을 해야하기에 그것을 찾아내는 건 무척 귀찮고 힘들죠.
)
(
단일 진실 공급원이라고 직역되는 이 SSOT는 데이터 요소에 대해 정확하고 신뢰할 수 있는 최신의 값을 하나만 존재해야한다는 의미
즉, 결국 데이터의 일관성과 정확성을 유지하기 위함으로 데이터 중복을 방지하자는 취지
)






# 흐름 및 역할

<p align="center">
  <img height="300" src="https://github.com/user-attachments/assets/54e486cd-fb93-41f8-9cc0-8d45477c9253">
  <img height="300" src="https://github.com/user-attachments/assets/8cdea53a-3e33-441a-975e-1ee01379eb94">
</p>



## 🎯 State
: 비지니스로직을 수행하기 위한 데이터, UI를 렌더링 하기위해 필요한 데이터.  

```swift
// struct CounterFeature: Reducer {  }  // 프로토콜 사용 

@Reducer // 메크로사용
struct CounterFeature {
    struct State: Equatable { // <-- State
        var count = 0
    }
}
```
***Featrue ?***  
특정 기능이나 모듈을 의미하고, 상태(State), 액션(Action), 리듀서(Reducer), 환경(Environment)을 포함함.  
논리적인 구성. 구현체(인스턴스)는 스토어?  


***Equatable ?***  
```Equatable``` 프로토콜(struct를 비교하기 위한)을 채택해야함. 
State의 업데이트를 관찰하여 비교하고 이후 뷰를 업데이트 하기때문에. 불필요한 랜더링을 방지함. 

Action에도 ```Equatable``` 프로토콜을 채택하는 것은 필수는 아니지만, 테스트 가능성을 높이기 위함. 

## 🎯 Action
: 디바이스와 ```사용자 인터렉션```을 받아오기 위한 타입.  

알림창을 닫거나, API의 request를 받던가, 타이머를 작동시킨다거나 하는 복잡한동작도 Action에 추가 가능.  

이러한 Action이 State를 변경하거나,  
외부와 통신할 수 있는 Effect를 반환시키도록 트리거역할을 함.  

```swift
@Reducer
struct CounterFeature {
    struct State: Equatable {
        var count = 0
    }
    
    enum Action: Equatable {
				//숫자 증감버튼들을 탭할때의 상황
		    case incrementButtonTapped
		    case decrementButtonTapped
		}
   
    var body: some ReducerOf<Self> {/* code */}
}
```

***Action 네이밍 컨벤션***  
UI에서 수행할 작업의 이름을 따서 짓는 것을 추천   
UI에서 어떤 액션을 어디로 보내야할지 알기 쉽고, 테스트할때 또한 더욱 명확하고 이해하기 쉬워짐.  

```swift
enum Action: Equatable {
	// 추천
	/* ✅ */ case incrementButtonTapped 
	// 비추천
  /* ❌ */ case incrementCount        
}
```


## 🎯 Reducer
: 변경을 처리함.  
Action을 바탕으로 State를 변경(mutating)하거나, Effect가 존재하면 Store를 통해 어떻게 실행되어야 하는지를 설명하는 


프로토콜을 채택하거나, @Reducer 메크로 사용 <- 이게 Reducer야? Feature에 하는데.. 바로 ```let reducer: Reducer<,>``` 이렇게 변수로 사용할 수도 있다는 것 같음.  

ㄹㅇ Reducer는 변경을 처리하기 위한 로직을 정의한 것.  

Reducer를 정의 하는 방법은 두가지가 있음. [reducer 문서](https://pointfreeco.github.io/swift-composable-architecture/1.0.0/documentation/composablearchitecture/reducer/)


```swift
public protocol Reducer<State, Action> {
  func reduce(into state: inout State, action: Action) -> Effect<Action>
  
  @ReducerBuilder<State, Action>
  var body: Body { get }
}

```

### 1. reduce 메서드. reduce(into state: inout State, action: Action) -> Effect<Action>
```swift

```

### 2. body 연산프로퍼티 get. Opaque Type(불투명한 타입, 'some')으로 반환
```swift

```

## 🎯 Dependency

## 🎯 Effect

## 🎯 Store와 ViewStore

## 
