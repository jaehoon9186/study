# more testable code(DI, POP)

### 참고 
- [Protocol Oriented Programming (Swift 5) MVVM & Unit Test](https://www.youtube.com/watch?v=vBgOnzc7Urg&t=2123s)
- [medium post](https://medium.com/@farid.stairs/dependency-injection-di-and-unit-testing-with-swift-58d7742019cc)


# 

DI, pop를 이용 더욱 testable한 코드를 만들자.  

외부 라이이브러리로는 Swinject, Pure, Dip, Typhoon 등이 있는것 같음.  

# Dependency Injection

의존성 주입은 클래스내에서 개체생성을 하지않고 외부에서 종속성을 전달하는 패턴임.  

다양한 방법이 있는데, property injection, initializer injection, protocol injection이 있는것 같음.  

DI를 함으로서 디캐플링하여 응집도를 높여 단위테스트를 하기 용이하다. 


# protocol oriented programming

구현체가 아닌 프로토콜에 의존적이면, 구현을 바꾸기 쉽다.  
= 프로토콜을 준수하는 mock과 stub을 만들기 쉽다.
