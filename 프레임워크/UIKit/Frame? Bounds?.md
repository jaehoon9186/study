# Frame? Bounds?
[Frame](https://developer.apple.com/documentation/uikit/uiview/1622621-frame)  
[Bounds](https://developer.apple.com/documentation/uikit/uiview/1622580-bounds)  


## 요약 
애플 공식 문서의 요약본을 봐보자.
> ### frame: <br>

  The frame rectangle, which describes the view’s location and size in its superview’s coordinate system.
  ```swift
  var frame: CGRect { get set }
  ```
> ### Bounds: <br>

  The bounds rectangle, which describes the view’s location and size in its own coordinate system.
  ```swift
  var bounds: CGRect { get set }
  ```

둘다 CGRect 구조체 타입의 Instance Property이다.
