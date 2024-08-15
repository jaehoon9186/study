# TCA 3.md
- [https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/#resources](https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/#resources)

* 카운터앱
* side effects 추가 <<<<<
* Testing
* composing features


# side effects 튜토리얼 

일반적으로 side effect 는 부작용이라는 뜻인데..  

TCA에서는 outside world와 상호작용을 통해 발생하는 작업? 을 말하는 것 같음.  

예를 들어 making API requests, interacting with file systems, performing time-based asynchrony   



해당 튜토리얼에서는 간단한 API request와 간단한 타이머를 구현하는 과정을 설명함.  

---

reducer 내부에서 비동기 통신을 수행했을 때

```swift
case .factButtonTapped:
        state.fact = nil
        state.isLoading = true
        
        let (data, _) = try await URLSession.shared
          .data(from: URL(string: "http://numbersapi.com/\(state.count)")!)
        // 🛑 'async' call in a function that does not support concurrency
        // 🛑 Errors thrown from here are not handled
        
        state.fact = String(decoding: data, as: UTF8.self)
        state.isLoading = false
        
        return .none
```
<img width="789" alt="스크린샷 2024-08-15 오후 8 31 38" src="https://github.com/user-attachments/assets/4b722947-3224-4310-aff0-7f8b59124430">

이런 에러를 볼 수 있음.  

URLsession을 사용해 reducer 에서 직접 수행하고 싶지만.  
reducer 내부에선 비동기 작업이 허용되지 않음. 

왜 ? 
복잡한 side effects 에서 
pure, simple 변환을 분리하기 위해, <- TCA 라이브러리의 핵심원칙중 하나. 여러 이점이 있음.  

이를 수행 하기 위해 적합한 도구를 제공함.  

.run()
이라는 static method를 제공함.  

트레일링 클로저에 수행하기 위한 비동기 작업을 정의하면 됨. 

--- 

타이머 동작시 멈추지 않는다. 어떻게 

TCA는 effect를 종료하는 기능도 제공함.  
cancellable(id:cancelInFlight:) 메서드임 
ID를 제공해야하며. 

나중에 cancel(id:) 메서드를 이용해 캔슬 할 수 있음. 







# 코드
<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/94f78f2b-7610-4f59-ab02-98a3e4136b41">
</p>


```swift
import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {

    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factResponse(String)
        case factButtonTapped
        case timerTrick
        case toggleTimerButtonTapped
    }

    enum CancelID { case timer }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none

            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true

                return .run { [count = state.count] send in       // 캡쳐리스트로 state 캡쳐, 비동기 통신이라 시점문제 때문에 그런듯. 
                    let (data, _) = try await URLSession.shared
                              .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)   
                    await send(.factResponse(fact))               // 단순이 state를 변경하고자 하면 에러. 
                }

            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none

            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none

            case .timerTrick:
                state.count += 1
                state.fact = nil
                return .none

            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()

                if state.isTimerRunning {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTrick)
                        }
                    }
                    .cancellable(id: CancelID.timer)

                } else {
                    return .cancel(id: CancelID.timer)

                }
            }
        }
    }
}
```

```swift
import ComposableArchitecture
import SwiftUI

struct CounterView: View {
    let store: StoreOf<CounterFeature>

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

            Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                store.send(.toggleTimerButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)


            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)

            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
```
