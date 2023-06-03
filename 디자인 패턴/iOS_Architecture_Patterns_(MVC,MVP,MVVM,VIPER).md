# iOS Architecture Patterns *MVC,MVP,MVVM,VIPER*

## 왜 Architecture Patterns을 선택하는 것을 신경써야하나?

언젠가 많은 기능들이 엮인 클래스를 디버깅하게 되는 경우가 온다면, 문제를 찾고 해결하기 매우 어려울 것이다.  
-> 협업에서의 용의성. 코스트 감소. 스파게티 코드로 인한 개발 비용의 증가를 예방한다. 

프로젝트의 규모에 따라 아키텍처 패턴을 선택, 채택한다. 

#### 좋은 아키텍처 패턴은? :
1. Balanced distribution of responsibilities among entities with strict roles.  
  : 엄격한 룰에 따라 가진 객체들 간의 균형있게 책임 분리. *```단일 책임 원칙(SRP of SOLED)```.  
    * *WHY?*  
     분리를 하게 된다면 해당 객체가 어떻게 동작하는지 빠르게 판단이 가능하게 된다.  
    이를 용이하게 하기 위해 단인 책임 원칙을 적용하여 객체들의 책임을 쪼개는 것이다.  
2. Testability usually comes from the first feature (and don’t worry: it is easy with appropriate architecture).  
  : ```테스트 가능함``` / 첫번째 특징에서 비롯하는 ( 적절한 아키첵처를 고른다면 어렵지 않을 것 ). 
    * WHY?  
     테스트가 가능하도록 개발 함으로서 런타임 내에서의 이슈를 찾기 용이하다. 
3. Ease of use and a low maintenance cost.  
  : ```사용 편의성```과 낮은 유지 보수 비용.  
    * WHY?  
     가장 좋은 코드는 하나도 작성하지 않은 코드이다. 가장 적은 양의 코드는 버그가 적다.  
     

## 필수 MV(X)
다양한 아키텍처 패턴들이 있다. 
* MVC
* MVP
* MVVM
* VIPER

위 세개는 아래의 카테고리를 포함한다. :
1. Models<br>
  : 도메인 데이터 또는 데이터를 조작하는 데이터 액세스 계층을 담당한다. 
2. Views<br>
  : iOS 환경의 프리젠테이션 레이어(GUI)를 담당한다.<br>
   'UI'로 시작하는 것들을 생각하면 됨. 
3. One of Controller / Presenter / ViewModel<br>
  : Model 과 View 사이의 중재자<br>
    일반적으로 View에서 수행된 사용자의 행동에 반응하고<br>
    Model의 변경 사항으로 View를 업데이트하여 Model을 변경할 책임을 갖는다. 

<br>

개체들을 나눈다면 :
* 더 잘 이해하게 됨
* 재사용 가능( View 와 Model에 대부분 적용가능 )
* 독립적으로 테스트 가능


## *MVC*
#### 이전에는 어떻게 사용했나? 전통적인 MVC 패턴

<img width="717" alt="스크린샷 2023-06-02 오후 5 50 41" src="https://github.com/jaehoon9186/study/assets/83233720/068a10ee-2991-4f5a-8257-2e47a04fb47d">

**View**의 범위가 명확하지 않다. **Model**이 변경되면 **Controller**에 의해 간단히 랜더링된다. 웹페이지에서 다른 페이지로 이동하는 것을 생각해 봐라. iOS에서 전통적인 MVC를 구현하는 것은 가능할 지라도, 구조적인 문제 때문에 효과적으로 처리할 수 없고,(모든 세개의 개체가 둘씩 꽉 묶여있고, 각 개체는 다른 두개에 대해 알고 있다. 이것은 재사용성을 심각하게 줄인다.) 앱 또한 원치 않는다. 이러한 이유로, 일반적인 MVC는 PASS.

전통적인 MVC는 현대의 iOS 개발에 적합해 보이지 않는다.
  

## *apple's MVC*
#### **기대**
<img width="685" alt="스크린샷 2023-06-02 오후 5 51 16" src="https://github.com/jaehoon9186/study/assets/83233720/2497be7f-f4b2-4f46-9fc0-e3ca16335591"><br>
[애플 MVC](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)<br>
애플의 MVC는 전통적인 MVC이 뮤와 모델이 분리 되어 있지 않기 때문에 재사용성이 떨어진다는 점을 개선하여 만든 디자인패턴이다.

원래 **Controller**는 **Model**과 **View**를 연결시켜주는 역할을 하므로 서로에 대해 알 필요가 없다. 
이 중 가장 재사용을 덜 하는 곳은 Controller이다. 따라서 특이한 로직들은 Model이 아닌 Controller에 넣어야한다.  -> Massive View Controller 


#### **현실**
<img width="701" alt="스크린샷 2023-06-02 오후 5 51 29" src="https://github.com/jaehoon9186/study/assets/83233720/9ea6d2dc-f77f-4a7e-a641-3d9632e033cc">



장점 :
* 구조가 단순하여 이해하기 쉽다. 
* 코드가 다른 패턴들에 비해 적다. 
* 애플에서 기존적으로 지원하는 패턴이기에 접근성이 좋다. 
* 아키텍처 쪽에 투자할 시간이 없을 때 선택, **개발속도가 빠르다.**

단점 : 
* 규모가 커진다면 유지보수 비용이 지나치게 들어간다. 
  * controller에 많은 로직이 (life cycle, delegate, 네트워크요청, DB 요청 등) 들어 가기때문에 controller의 크기는 비대해지고 복잡해짐
* View와 Controller가 밀접히 붙어있기 때문에 재사용성이 떨어지고, 유닛테스트를 진행하기 어렵다. 


> CODE
```swift



```


## *MVP*
> MVP ?  
<img width="712" alt="스크린샷 2023-06-02 오후 5 51 45" src="https://github.com/jaehoon9186/study/assets/83233720/07e3c5ce-50c8-42a4-a093-d74a0aab023a">
<img width="702" alt="스크린샷 2023-06-02 오후 5 52 06" src="https://github.com/jaehoon9186/study/assets/83233720/ef75a98e-e758-480f-a09c-9ae2c65ec0eb">

이미지 

설명 

> 코드

* 설명1
* 설명2

## *MVVM*
<img width="716" alt="스크린샷 2023-06-02 오후 5 52 18" src="https://github.com/jaehoon9186/study/assets/83233720/c971b9e6-0fd6-423f-8195-3b6686287100">

## *VIPER*
<img width="732" alt="스크린샷 2023-06-02 오후 5 52 39" src="https://github.com/jaehoon9186/study/assets/83233720/7d94d00c-ede5-48a0-aa2e-7165465431c4">



## 참고
[참고글](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52)  
[참고깃헙](https://github.com/haxpor/ios-design-patterns)  
