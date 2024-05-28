# Animation - Transaction, Implicit(암시적) and Explicit(명시적)

- [https://talk.objc.io/episodes/S01E285-animations-and-transactions](https://talk.objc.io/episodes/S01E285-animations-and-transactions)
- [https://holyswift.app/difference-between-implicit-and-explicit-animations-in-swiftui/](https://holyswift.app/difference-between-implicit-and-explicit-animations-in-swiftui/)

# Transaction?

상태(State)가 변경될 때 어떻게 처리할 것인지에 대한 컨텍스트, 구조는 딕셔너리?

스유에서는 상태가 변경될 때마다 트랜잭션이 생성됨. 상태변경이 암시적 or 명시적으로 시작되었는지 여부에 따라 생성된 다음 뷰 계층 구조 전체에 전파됨. 

Environment 와 같이 뷰 계층구조에서 암시적으로 전달 됨.  

자체적으로 생성, 전달은 불가함. 

view modifier로 [.transaction](https://developer.apple.com/documentation/swiftui/view/transaction(_:)) 을 이용하여 관찰 조작 가능.  
(디버깅하거나, 새 트랜젝션이 생성되는 방법, 시기를 제어)  

상태변경에 따른 애니메이션 설정을 가지고, 영향을 받는 뷰로 전달함. 

영향받는 뷰(animatable protocol 준수하는)는 컨텍스트(트랜잭션)를 가져오고, animation curve function을 얻고, 그리고 애니메이션에 대한 보간을 계산함. 




# Implicit(암시적) and Explicit(명시적) animation ?

암시적인지 명시적인지에 따라 어느곳에 트랜잭션이 전달되는 지 결정. 

* implicit, 암시적
  - view modifier인 ```.animation``` 으로 지정한 경우
  - 지정된 컴포넌트로만 트랜잭션이 전달됨.
  - 상위뷰에서 지정한다면 withAnimation과 동일하게? 모든 자식뷰에 트랜잭션이 전달됨. (아하의 예제에서는 VSTACK에서 실핼할 수 있겠음.)
  - 특정조건이나 상태변경이 발생할때, 스유에 의해 생성되어 제어됨. 개발자는 통제 어려움. 
* Explicit, 명시적
  - 전역 메서드인 ```withAnimation```, ```withTransaction``` 메서드로 트리거하는 경우.
  - 루트뷰까지 트랜잭션이 전달됨.
  - 개발자가 명시적으로 만들고 제어한다



```swift
@State var isExpanded = false

var body: some View {
    VStack {

        Circle()
            .fill(.yellow)
            .frame(height: 50)

        Rectangle()
            .fill(.red)
            .frame(height: isExpanded ? 500 : 100)
            // .transaction 여기서 확인?
            .animation(.default, value: isExpanded) // MARK: 1

        Circle()
            .fill(.green)
            .frame(height: 50)

        Button {
            isExpanded.toggle()
            // withAnimation {          // MARK: 3
            //     isExpanded.toggle()
            // }
        } label: {
            Text("Change Size")
        }
        .buttonStyle(.borderedProminent)

    }
    // .animation(.default, value: isExpanded) // MARK: 2
    .padding()
}
```

---

가운데 사각형만 암시적으로 애니메이션을 적용한 경우.   
암시적으로 애니매이션을 지정한 빨간 사각형에만 트랜잭션이 전달되고 애니메이션이 동작함.  

<p align="center">
  <img height="250" src="https://github.com/jaehoon9186/study/assets/83233720/75c46bd9-af41-4c14-933b-a75926c5a685">
</p>


---

MARK3 명시적으로 애니메이션을 적용한 경우.  
모든 컴포넌트에 전달됨.  

<p align="center">
  <img height="250" src="https://github.com/jaehoon9186/study/assets/83233720/f95c75b7-d047-4cee-870a-193beebf5151">
</p>


