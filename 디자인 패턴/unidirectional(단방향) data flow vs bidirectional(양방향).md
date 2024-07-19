# unidirectional(단방향) data flow vs bidirectional(양방향).md
- [https://www.youtube.com/watch?v=ffR_KI-BkcM](https://www.youtube.com/watch?v=ffR_KI-BkcM)
- [https://kean.blog/post/swiftui-data-flow](https://kean.blog/post/swiftui-data-flow)
- [https://medium.com/wix-engineering/the-rise-of-flux-how-facebooks-shift-away-from-mvc-led-to-a-new-era-of-ui-architecture-61d78b4377b0](https://medium.com/wix-engineering/the-rise-of-flux-how-facebooks-shift-away-from-mvc-led-to-a-new-era-of-ui-architecture-61d78b4377b0)
- [https://medium.com/hacking-and-gonzo/flux-vs-mvc-design-patterns-57b28c0f71b7](https://medium.com/hacking-and-gonzo/flux-vs-mvc-design-patterns-57b28c0f71b7)
- [https://medium.com/myrealtrip-product/%EB%8B%A8%EB%B0%A9%ED%96%A5-%EB%8D%B0%EC%9D%B4%ED%84%B0-%ED%94%8C%EB%A1%9C%EC%9A%B0-unidirectial-data-flow-udf-ios-%EC%95%B1-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98%EB%A1%9C-%EB%B3%B5%EC%9E%A1%ED%95%9C-%EC%83%81%ED%83%9C-%EA%B4%80%EB%A6%AC%ED%95%98%EA%B8%B0-196a6c4f3b66](https://medium.com/myrealtrip-product/%EB%8B%A8%EB%B0%A9%ED%96%A5-%EB%8D%B0%EC%9D%B4%ED%84%B0-%ED%94%8C%EB%A1%9C%EC%9A%B0-unidirectial-data-flow-udf-ios-%EC%95%B1-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98%EB%A1%9C-%EB%B3%B5%EC%9E%A1%ED%95%9C-%EC%83%81%ED%83%9C-%EA%B4%80%EB%A6%AC%ED%95%98%EA%B8%B0-196a6c4f3b66)

TCA를 공부하며,  
왜 단방향플로우를 지향하게 됬는지 궁금해 알아봄.  

예전 페이스북은 MVC를 도입했었는데 규모가 커짐에 따라  
의존성을 제어하기 어렵고, 원치않은 상황에 알람이 추가되는 예측되지 않는 문제가 발생. 앱이 복잡해짐을 알게됨.  
이는 MVC의 양방향플로우때문이였음.  

따라서 Flux라는 아키텍쳐를 만듦. 
이후 다양한 단방향 아키텍처 패턴이 등장 Redux, Elm, TCA 등등.. 



# bidirectional data flow
aka. two-way data binding   
양쪽으로 이벤트가 흐름. 


MVC를 에로 들어 설명함.  


<p align="center">
  <img height="200" src="https://github.com/user-attachments/assets/f8ead7a5-1ab5-491d-9b73-db740fab083f">
  <img height="200" src="https://github.com/user-attachments/assets/6deb5197-0ba9-4cd9-9880-491276ce0e3e">
  <img height="200" src="https://github.com/user-attachments/assets/d95bd6d0-71e1-4adb-8922-cd63746df9af">
</p>

(1) 오리지널 MVC, 단방향이긴함. but, MVC창시자가 뷰가 모델을 업데이트 할 수 있다고함(양방향). 또한 실제로 양방향으로 MVC가 사용되고 있음.  

(2) 페이스북은 이러한 MVC의 문제점을 제시함. 규모가 커짐에 따라, view: model이 다대다 관계로 복잡도가 증가함.  

내부적으로 여러곳에 의존적인 경우도 있고,  

이는 예상치 못한 문제를 야기하기도하고,  

디버깅, 유지보수, 추척 어려움.   



(3) 애플의 MVC는 MVC보단 MVP 지만,  양방향으로 흐름
```
모델 > 컨트롤러 > 뷰: 모델의 변경 사항이 컨트롤러를 통해 뷰에 반영
뷰 > 컨트롤러 > 모델: 뷰에서 발생한 사용자 입력이 컨트롤러를 통해 모델에 반영
```


# unidirectional data flow
aka. one-way data binding
이벤트가 한방향으로만 흐름
  
단방향 아키텍처 패턴이 디게 많은것 같은데 공부는 swift에서 널리 사용되는 TCA진할 할 것이고   
지금은 flux로 간단한 개념만 알아볼것임.  

위의 양방향 플로우를 해결하기위해 페북에서 Flux를 react에 제안함.  


<p align="center">
  <img height="200" src="https://github.com/user-attachments/assets/5801fe39-5bce-440d-a252-0199068b18fc">
  <img height="200" src="https://github.com/user-attachments/assets/186b5813-a386-4ad0-aa9e-714241090ed2">
</p>



데이터가 한 방향으로만 흐르기 때문에 상태 변경의 원인을 추적하기 쉬움.  
애플리케이션의 상태가 어떻게 변하는지 명확히 이해할 수 있음.  
  
상태 변경과 관련된 모든 로직이 명확히 정의되어 있어, 문제를 디버깅하기가 상대적으로 쉬움.  
  
데이터 흐름이 단방향으로 유지되므로, 컴포넌트 간의 의존성이 줄어들고 복잡도가 낮아짐.  






# SwiftUI의 property wrapper는 양방향 데이터 플로우를 따른다?


swiftUI의 프로퍼티 래퍼는 양방향이다? < 근거?  

그래서 combine을 사용하는 TCA에서는 단방향으로 사용하기 위해 ~하도록 제한했음? 


property wrapper의 양방향 플로우로 인한 단점은?


# Flux 는 또 다른 MV* 패턴중 하나이다 ?

그런 의견도 더러 있는 듯함. 

- [https://stackoverflow.com/questions/33447710/mvc-vs-flux-bidirectional-vs-unidirectional](https://stackoverflow.com/questions/33447710/mvc-vs-flux-bidirectional-vs-unidirectional)
- [https://www.youtube.com/watch?v=nYkdrAPrdcw&t=36s / 댓글](https://www.youtube.com/watch?v=nYkdrAPrdcw&t=36s)

