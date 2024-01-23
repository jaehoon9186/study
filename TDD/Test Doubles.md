# Test Doubles

### 참고 
- [Test Doubles by example in Swift (예제 참고할 것)](https://medium.com/@pena.fernan/test-doubles-by-example-in-swift-558e9f47de52)
- [Test Doubles in Swift](https://bocato.medium.com/test-doubles-in-swift-68d04884de73)
- [UnitTest 개념 소개 / blog](https://hcn1519.github.io/articles/2021-09/unittest)
- [Test doubles 정리 / blog](https://brunch.co.kr/@tilltue/55)

# What is?
Test Double은 테스트 목적으로 만드는 객체 산출물을 지징합니다. 

# 종류 
![image](https://github.com/jaehoon9186/study/assets/83233720/72444a07-abe2-4840-a7ef-5e9a7df4b580)


총 5가지  

* dummy: 매개변수로는 사용하지만 테스트에 아무런 영향이 없는 객체, 테스트할 클래스 생성을 위해 
* Fake: 테스트에 영향줌, 테스트의 복잡성을 줄이고 구현을 단순화하여 실제 동작을 가짜로 모방하는 것. i.g. inMemoryTestDatabase
* Stub: 요청에 따라 미리 준비해둔 결과를 제공, 프로그래밍된 것 이외의 어떤것도 제공하지 않음. 
* Spy: 호출된 방식에 따라 정보를 기록하는 stub. 예를 들어 메일 전송 횟수 기록 등.
* Mock: 호출에 대한 기대를 미리 정의하고, 해당 내용에 따라 동작하도록 프로그래밍 된 객체 

