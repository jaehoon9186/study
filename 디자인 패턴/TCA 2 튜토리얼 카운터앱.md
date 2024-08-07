# TCA 2
- [https://pointfreeco.github.io/swift-composable-architecture/1.0.0/tutorials/meetcomposablearchitecture/#resources](https://pointfreeco.github.io/swift-composable-architecture/1.0.0/tutorials/meetcomposablearchitecture/#resources)
- [최신 https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/#resources](https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/#resources)
튜토리얼을 참고해 카운트 하는 간단한 예제를 만들어 보겠음. 

* 카운터앱
* side effects 추가
* Testing


# 카운터앱

## 0. SPM(swift package manager)으로 TCA 라이브러리 설치 
<p align="center">
  <img width="596" alt="스크린샷 2024-08-05 오후 5 28 19" src="https://github.com/user-attachments/assets/df63b28d-b366-4a6e-badb-01e82230f93f">
  <img width="1141" alt="image" src="https://github.com/user-attachments/assets/803930bc-4943-4669-ae94-84fd62686179">
</p>

1. 프로젝트 또는 상단 File에서 패키지 디펜던시 추가
2. url 이용해 검색, 설치 

url: https://github.com/pointfreeco/swift-composable-architecture

## 1. Feature 정의 
Feature: 특정 기능이나 모듈을 의미하고, 상태(State), 액션(Action), 리듀서(Reducer), 환경(Environment)을 포함함.

</br>

구조체로 Reducer() 메크로와 함께 Feature를 정의함.  
예전 TCA 버전에서는 Reducer 프로토콜을 채택했었는데 그 역할(+⍺)을 함.  

</br>

Feature를 Domain이라고도 하는듯?  
도메인을 모델링 해야함. 
구성으론 State, Action 이 있는데, 일반적으로 State는 struct, Action은 enum 타입으로.   

</br>

State? 
리듀서의 상태, 뷰에 보여질 것들.  

ObservableState() 메크로를 사용함.  
- [Using @ObservableState in page link](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/migratingto1.7/#Using-ObservableState)
- [viewstore](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/viewstore)

1.7버전 이후로는 ObservableState() 메크로를 사용해 뷰에서 관찰가능하도록 함.  
ViewStore 도큐먼트에 가보면 Deprecated되고 ObservableState() 메크로로 대체됬다고함.  
ViewStore는 View에 필요한 상태만을 구독하고 업데이트하는 역할을 수행했음, 뭐 바인딩도 하고 그랬음.  
(참고, Store는 앱의 상태변화를 관리)   
(SwiftUI에선 해당하는 것 같은데 UIKit도 마찬가지 인가?)  

</br>

Action?
네이밍컨벤션으로 UI에서 수행할 작업을 정의.  

</br>

Reducer?
로직 수행  

마지막으로 Reducer 프로토콜을 준수하기위해 body property를 정의해 줘야함.  
(reduce 메서드도 가능.)  

body 내부엔 effect 를 반환하는 reducer들을 구현함.  

간단한 에제라 일단 하나만 구현하고, effect도 일단 없어 .none으로  


```swift
import ComposableArchitecture

@Reducer
struct CounterFeature {

    @ObservableState
    struct State {
        var count = 0
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
    }

    var body: some ReducerOf<Self> {
        // Reduce(<#T##reduce: (inout State, Action) -> Effect<Action>##(inout State, Action) -> Effect<Action>##(_ state: inout State, _ action: Action) -> Effect<Action>#>)
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            case .incrementButtonTapped:
                state.count += 1
                return .none
            }
        }
    }
}
```


```swift
// 메크로 이전
struct CounterFeature: Reducer {
    struct State { }
    enum Action { }
    func reduce(into state: inout State, action: Action) -> Effect<Action> { }
}
extension CounterFeature.State: Equatable { }
```
직접 State가 Equatable 프로토콜을 채택하도록해도 됨.  
아님 extension으로 Equatable 프로토콜을 채택하도록 할 수 있음.  
메크로를 사용하는경우 불가한듯. 아니 필요없나? ObservableState() 메크로 사용해서?  


## 2. View 구성 

Store가 뷰를 구성할 때 필요한 개념? 컨셉? 임.  

Store?  
어플리케이션의 런타임 동안 Reducer의 인스턴스를 관리하는 참조 타입의 객체  
구조상 앱의 상태와 액션을 관리하고, 상태의 변화를 감지하고 이에따라 액션을 처리하는 역할을 함.  

Store의 데이터 관찰을 ObservableState()메크로에의해 자동으로 이뤄짐.  

뷰컴포넌트가 들어갈 body에는 바닐라 스위프트로 구성할 수 있음.  
.send() 로 store에 action을 보냄.  


```swift
import ComposableArchitecture
import SwiftUI

struct CounterView: View {
    let store: StoreOf<CounterFeature> // typealias로 축약해서 사용한 버전

    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}
```

뷰에서 Store를 주입

Store 생성자의 두번째 인자(트레일링클로저)에는 reducer가 필요한데 이걸 교체해서 테스트도 하고 그러는것 같음. 차차 해보면 알듯.  


```swift
#Preview {
    //    CounterView(store: StoreOf<CounterFeature>)
    //    Store(initialState: <#T##() -> R.State#>, reducer: <#T##() -> R#>)

    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
```




## 3. 앱 레벨

프리뷰에서 처럼 주입해도 됨.  

단, store는 한번만 만들어야 함.    

static선언해 주입할 수도 있음.  

```._printChanges(_:)```: 디버깅하기 쉽게 제공하는 메서드. 리듀서가 처리하는 작업을 콘솔에 출력해줌.    


```swift
import ComposableArchitecture
import SwiftUI

@main
struct SwiftUICounterTCAApp: App {

    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
          ._printChanges()
      }

    var body: some Scene {
        WindowGroup {
            CounterView(store: SwiftUICounterTCAApp.store)
        }
    }
}
```


## 4. 결과
<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/32285a40-62f1-412d-a7dc-6f9d87d12c66">
</p>




