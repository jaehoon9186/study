# IOC(제어의 역전)
- [https://medium.com/swift-india/inversion-of-control-ioc-384ec3f49569](https://medium.com/swift-india/inversion-of-control-ioc-384ec3f49569)




간단히,  
IoC(Inversion of Control; 제어의 역전)은 소프트웨어 설계 원칙 중 하나.  
목적? 소프트웨어의 유지 보수성, 확장성, 테스트 용이성을 향상시키는 데  
어떻게? DI를 통해  
예제? A 인스턴스가 B 인스턴스를 필요로 한다면, A 내부에서 B를 생성하는 대신 외부에서 B 인스턴스를 주입받아 사용합니다. 이렇게 하면 A는 B를 생성하거나 조작하는 것이 아니라 외부로부터 제어의 권한을 받아 사용. A가 B에 대한 제어권을 가지지 않고, 외부에서 B를 생성하고 제공함으로써 A는 단순히 주어진 B를 사용합니다. 이를 통해 A는 B의 구현에 대한 세부 사항을 신경 쓰지 않고도 B를 사용할 수 있음.  
