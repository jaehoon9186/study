# UIScreen

[Docs](https://developer.apple.com/documentation/uikit/uiscreen)

<img width="984" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/37a4011a-524e-4513-9902-6ab9724c975f">

하드웨어 디스플레이와 관련된 속성들을 정의하는 오브젝트라고함. 

# Overview

iOS 기기들은 하나의 main screen과 0개 또는 그 이상의 연결된 screen이 있음. tvOS 기기는 기기에 연결되된 TV를 위한 하나의 main screen을 가지고있음. 

UIWindowScene 오브젝트는 콘텐츠를 보여주기위한 screen을 위해 screen 오브젝트를 제공함. 각 screen 오브젝트는 연결된 화면을 위한 bounds rectangle과 밝기 같은 흥미로운 속성들을 정의함. iOS 8 과 이후버전에서는, screen's bounds 속성은 화면의 orientation(방향)을 고려하기 시작함. 이것은 세로방향 기기의 bounds가 가로방향 bounds의 bounds와 같지 않다는 것을 의미함. 스크린의 사이즈에 의존하는 앱들은 fixedCoordinateSpace 속성의 오브젝트를 계산해야하는 고정된 기준점으로 사용할 수 있음. ( iOS 8 이전에는, screen's bounds rectangle은 항상 세로방향을 기준으로 반영했다. 가로방향, 거꾸로 회전해도 bounds가 변경되지 않았음 ) 
