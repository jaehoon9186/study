# withObservationTracking 사용경험

- [https://swiftwithmajid.com/2023/10/03/mastering-observable-framework-in-swift/](https://swiftwithmajid.com/2023/10/03/mastering-observable-framework-in-swift/)
- [https://augmentedcode.io/2024/08/12/cancellable-withobservationtracking-in-swift/](https://augmentedcode.io/2024/08/12/cancellable-withobservationtracking-in-swift/)
- [https://forums.swift.org/t/how-to-use-observation-to-actually-observe-changes-to-a-property/67591/2](https://forums.swift.org/t/how-to-use-observation-to-actually-observe-changes-to-a-property/67591/2)

왜 인지 컴바인으론 뷰가 업데이트되질 않아서.. (메인스레드에서 동작하는데도).  

withObservationTracking으로 해결한 경험.  

1) 한번만 관찰하기때문에 지속적으로 관찰히도록 작업해야함. (재귀적로)

2) willSet으로 동작하기때문에 didSet으로 동작하도록 해야함. 
forums.swift.org의 답변처럼. 단순히 지연 후 동작하도록 하도 가능하나.. 이상적이지 않음.

후에 필요하다면 augmentedcode.io의 게시글을 참고해 보자. 
