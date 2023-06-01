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
다양한 아키첵터 패턴들이 있다. 
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




## *MVC*

## *apple's MVC*

## *MVP*
> MVP ?  

이미지 

설명 

> 코드

* 설명1
* 설명2

## *MVVM*

## *VIPER*



## 참고
[참고글](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52)  
[참고깃헙](https://github.com/haxpor/ios-design-patterns)  
