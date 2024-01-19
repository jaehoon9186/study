# MVVM, input-output.md

<img width="700" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/b8ef40ad-296b-42a5-8bd3-0d5af2a18b59">


View와 ViewModel사이 Input, Output을 정의합니다. 

* 구조화 함으로 이벤트흐름을 파악하기 쉽다.(가독성 )
* 비동기처리를 간단하게 작업가능, 여러 퍼블리셔를 결합하기도 용의하다고함.

rxSwfit MVVM에 많이 사용된 패턴같은데 Combine은 많이들사용하는 정형화된 레퍼런스가 뭔지 모르것네요. 


### 참고 
- [Youtube / Kelvin Fok / MVVM Combine Swift (2022) | UIKit | Transform Input & Output](https://www.youtube.com/watch?v=KK6ryBmTKHg&t=2089s)
- [Blog Post / [UIKit] MVVM Input-Output 패턴 사용에 대한 고찰 (with Combine)](https://www.heon.dev/swift/mvvm-input-output-pattern)
- [github post](https://github.com/YoonAh-dev/ImageExample_Pattern/blob/main/ImageExample_MVVM_Combine/ImageExample_MVVM_Combine/ViewModel/ViewModel.swift)

# 흐름 

Input과 Output을 정의합니다. 각각 Input은 유저액션을, Output은 반환값(결과)를 정의 합니다.  
View에서는 Output을 subscribe하고, ViewModel에서는 Input을 Subscribe합니다. 양방향으로 바인딩하여 비동기로 수행.  

1. View에서 이벤트 발생. 버튼 누르기 등
2. ViewModel에서 이벤트(Input)에 대한 비지니스 로직 수행
3. Output를 반환


# 적용
- [개인 프로젝트 / SearchAPP](https://github.com/jaehoon9186/SearchAPP) 
