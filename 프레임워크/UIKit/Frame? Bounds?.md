# Frame? Bounds?
[Frame](https://developer.apple.com/documentation/uikit/uiview/1622621-frame)  
[Bounds](https://developer.apple.com/documentation/uikit/uiview/1622580-bounds)  

[스크롤뷰 블로그](https://oleb.net/blog/2014/04/understanding-uiscrollview/)

## 간단 정리 

## 요약 & 설명
애플 공식 문서의 요약본을 봐보자.
> ### frame: <br>

  The frame rectangle, which describes the view’s location and size in its **superview’s coordinate system.**
  ```swift
  var frame: CGRect { get set }
  ```
> ### Bounds: <br>

  The bounds rectangle, which describes the view’s location and size in its **own coordinate system.**
  ```swift
  var bounds: CGRect { get set }
  ```

둘다 CGRect 구조체 타입의 Instance Property이다.  
CGRect를 보니 CGPoint, CGSize로 구성된 구조체다. 
frame이랑 bouns는 좌표와, 사이즈로 구성된 사각형의 UIView구나. 

요약을 들여보니 좌표를 정하는 기준이 다른것 같다.  
Frame: 슈퍼뷰의 좌표계를 기준으로  
Bounds: 자신의 좌표계를 기준으로  

> 추가. 

Discussion에 UiKit은 redraw하려면 set the contentMode property to UIView.ContentMode.redraw. 해야한다던데 이하의 글들도 참고해보자.  
[redraw 관련 1](https://useyourloaf.com/blog/stretching-redrawing-and-positioning-with-contentmode/)  
[redraw 관련 2](https://eunjin3786.tistory.com/99). 

## Frame 
<img width="200" alt="스크린샷 2023-06-16 오후 7 17 37" src="https://github.com/jaehoon9186/study/assets/83233720/e2ca0a6f-e5fc-4ffc-a4cc-836b1c104829">
<img width="640" alt="스크린샷 2023-06-16 오후 7 17 37" src="https://github.com/jaehoon9186/study/assets/83233720/8d8d639a-1c58-4943-8cf6-d47ef950193b">
  
분홍색 뷰의 슈퍼뷰는 흰색 뷰이다. 흰색뷰의 좌표계(좌상단, (0, 0))를 기준으로 x는 50, y는 100만큼 떨어진 상태에서 UiView가 그려진것. 
파란색 뷰의 슈퍼뷰는 분홍색 뷰임.  
  
<img width="200" alt="스크린샷 2023-06-16 오후 7 24 40" src="https://github.com/jaehoon9186/study/assets/83233720/48b8d1d5-91a2-41f6-9903-311b21faf2c7">
<img width="640" alt="스크린샷 2023-06-16 오후 7 24 40" src="https://github.com/jaehoon9186/study/assets/83233720/614a8719-a718-4b04-89dc-aa3928fd52a9">
  
분홍색 뷰를 회전시킨 경우임.  
흰색뷰의 좌표계를 기준으로  
<img width="150" alt="이미지" src="https://github.com/jaehoon9186/study/assets/83233720/9d8de48c-3b0e-44d6-87c4-0ee79c56c8c5">  


## Bounds 
슈퍼뷰가 아닌 본인을 기준으로 한다.

<img width="200" alt="스크린샷 2023-06-16 오후 7 17 37" src="https://github.com/jaehoon9186/study/assets/83233720/2bb71c20-c1f3-464e-a4e1-8257f9a6a803">
분홍색 뷰의 바운드를 변경하는 애니메이션임.  
스크롤뷰 같은 것도 원리는 바운드 값을 수정하면서 스크롤 되는것 처럼 보여지는것.  
