# 왜 SwiftUI는 View를 class가 아닌 struct로?

### 참고
- [post / Why does SwiftUI define views using Struct?](https://medium.com/@frentebw/why-swiftui-defines-views-as-struct-c0b11b914baa)
- [post / SwiftUI View가 Struct인 이유에 관해](https://matdongsane.tistory.com/84)

---

UIKit은 class로 view를 구현, SwiftUI는 struct로 view를 구현하였다.  
왜?  

1. 안전성  
class는 참조(reference)타입, struct는 값(value)타입으로
* 참조타입에서 염려되는 메모리릭이 발생하지 않는다.
* class는 복사 시에 주소값이 복사되기때문에 사이드이펙트가 발생할 가능성이 있다.

<br>

2. 성능  
UIKit의 각각의 View 컴포넌트들은 상속으로 이뤄져있기에 무겁고 복잡함. Struct로 구현된 View는 단순하고 빠름.(struct는 stack에 저장되어 heap에 저장되는 class보다 엑세스가 더빠름.)



---
  
struct의 단점?을 보완한 점. 
- 상속을 대신해 ViewModifier
- 맴버변수를 변경하기위해 mutating 키워드를 사용해야함, @State 도입.
