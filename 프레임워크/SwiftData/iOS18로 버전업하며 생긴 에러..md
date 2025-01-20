# iOS18로 버전업하며 생긴 에러.md



```
SwiftData/BackingData.swift:663: Fatal error: This model instance was destroyed by calling ModelContext.reset
and is no longer usable.
PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID
(url: x-coredata://1A6DBCF8-F4F8-4762-9D6B-62BCA847D1A1/GroupModel/p1),
implementation: SwiftData.PersistentIdentifierImplementation)
```

이런 에러가 나옴.. 

iOS17에선 잘 돌아갔는데.. 18로 업뎃하며 이런 에러가 생김. 

기존상황 
modelActor를 통해 직렬로 처리함. modelContainer의 인스턴스를 vm 끼리 di 함. 
콘테이너는 app사이클 단계에서 생성함. 

문제? 모델액터의 인스턴스가 액터의 라이프사이클이 종료된 후에도 유지되고 있으면 발생하는듯.

- [https://forums.developer.apple.com/forums/thread/757521](https://forums.developer.apple.com/forums/thread/757521)


액터를 싱글톤으로? 
