# [weak self]? in closure

### 참고 
* [apple documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/#Strong-Reference-Cycles-for-Closures)
* [You don’t (always) need [weak self] / medium post](https://medium.com/@almalehdev/you-dont-always-need-weak-self-a778bec505ef)
* [The Nested Closure Trap / medium post](https://medium.com/flawless-app-stories/the-nested-closure-trap-356a0145b6d)
* [When do we REALLY need to use [weak self]? 🤔 / youtube video](https://www.youtube.com/watch?v=0sOrVoLOf7Q)
* [Capturing objects in Swift closures / swiftsundell article](https://www.swiftbysundell.com/articles/capturing-objects-in-swift-closures/)
* [Is using [weak self] always required when working with closures? / swiftsundell article](https://www.swiftbysundell.com/questions/is-weak-self-always-required/)
* [When should we change weakSelf to strongSelf? / stack overflow](https://stackoverflow.com/questions/45070678/when-should-we-change-weakself-to-strongself)

### 서두

클로저에서 retain cycle을 피하려고 [weak self] capture list를 자주 봅니다.  
언제 필요한 것인가에 대한 명확한 이해가 부족하여 공부하게 되었습니다. 

### index 
*
*
*
*

# [unowned self] vs [weak self]

unowned, weak 참조 둘다 reference count(이하 RC)를 증가시키지 않는 참조 방식입니다. 
단, unowned 의 경우 참조하는 대상이 반드시 존재한다는 전재 하에 사용해야합니다. 참조하는 대상, 인스턴스가 메모리에서 해제된 후 접근한다면 앱이 충돌납니다. unsafe하여 사용시 주의가 필요합니다. 

 
# closure에서는 언제 retain cycle이 발생하나요?

```swift
class SomeClass {
    var infomation: String = "클로저 참조 테스트 클래스"
    lazy var closure: () -> Void = { // ()->Void RC +1
        print(self.infomation) // SomeClass.instance RC +1
    }
    init() {
        print("init")
    }
    deinit {
        print("deinit")
    }
}

var a: SomeClass? 
a = SomeClass() // SomeClass.instance RC +1
a?.closure()
a = nil // SomeClass.instance RC -1
```
<img width="586" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/022cf6f3-c138-4d1a-bd74-d52316f5e86b">  
deinit이 실행이 안되는 상황.. ```SomeClass.instance``` 가 heap에 남아있음. 

</br>
</br>
  
위 예제에서 var closure는 self 키워드로 클로저가 위치한 인스턴스를 참조하게 됩니다.  
이 과정에서 ```SomeClass.instance```로의 강한 참조로 RC가 1증가하게 되고, a를 nil로 하여 강한 참조를 제거하더라도  
```SomeClass.instance```와 ```()->Void``` 함수는 서로 강한참조를 하고 있는 retain cycle 상황이므로 memory leak이 발생하게 됩니다.  

# 어떻게 해결할 수 있을까요?
```swift
    lazy var closure: () -> Void = { [weak self] in 
        print(self?.infomation)
    }
```
<img width="527" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/cc968b3c-94a9-47ee-a9ac-398b4f652b7f">   
</br>
정상적으로 deallocate 된 상황  </br></br>

캡처리스트로 self( SomeClass.instance )를 약한 참조(weak)을 하여 해결 할 수 있습니다.  
```()->Void``` 함수는 ```SomeClass.instance```를 약한 참조하게 되고, 이는 ```SomeClass.indstace```의 RC를 증가 시키지 않습니다.  
```a = nil```로 RC -1을 하게되면 ```SomeClass.instance```에 대한 RC가 0이 되어 ARC에 의해 메모리에서 해제 되고,  
```()->Void``` 함수를 참조하던 instance가 deallocate되어 마찬가지로 ```()->Void``` 함수의 RC도 0이 되어 메모리에서 해제됩니다.  


<img width="775" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/309f3b58-27e9-41b1-88c9-3cb315dcf301">   


# 언제 [weak self] 캡처리스트를 사용해야하나요?

<img width="918" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/e8e5bac6-bfc2-41f8-a8b5-3ba04712f938">

모든 클로저에 [weak self]를 사용할 필요는 없습니다. retain cycle을 유발하는 클로저에서만 사용하면 됩니다.   
그럼 전부다 [weak self] 쓰면 문제가 생기나요? 크게 문제는 생기지 않습니다. 단, 개발의도에 따라 실행되야할 부분도 실행이 안될 수 도 있고(개체를 유지해야하는 경우?), [weak self] 로 선언후 strong reference를 하려면 
코드가 지저분해질 우려도 있습니다. (옵셔널 바인딩으로 강한참조를 하기도 함 ?)
  > 추후에 꼭 strong 참조가 필요한 경우는 무엇인지 알아보자.
</br>

그럼, [weak self] 캡쳐리스트가 필요한 경우는?

## 1. escaping Closure? non-escaping closure? 

```@escaping``` **escaping Closure** 는 전달된 클로저가 스코프 내부에서 실행될수 있을 뿐 아니라 외부에 저장될 수 있음을 의미합니다.   
저장 될 수 있고, 다른 클로저로 전달 될수 있고, 미래에 특정한 시점에 실행 될 수 있는 escaping closure는 retain cycle을 만들 수 있습니다.  
이하 두가지의 조건에 해당한다면 **[weak self] 를 도입**해야합니다.  
* 프로퍼티에 저장되거나, 다른 클로저로 전달됨
* 클로저 내부의 객채(self)가 클로저에 strong reference를 가짐.

</br>

**non-escaping Closure** 는 클로저가 탈출을 하지 못하기 때문에 retain cycle을 만들수 없습니다. 


## 2. Delayed Deallocation 지연된 할당해제의 경우 

escaping, non-escaping에 상관없이 둘다 해당될 수 있습니다.   
retain cycle은 발생하지 않아 memory leak은 아니나, 예상치 못한 방향으로 동작할 수 있는 상황이 있습니다. (e.g. 컨트롤러를 닫았지만 보류중인 클로저가 작업이 완료될때 까지 메모리에 있는 경우)   
이런 경우에도 [weak self]를 도입할 수 있습니다. 

* (escaping/non-escaping 클로저) 비용이 많이드는 직렬 작업을 수행할 때
* (escaping/non-escaping) 범위 반환을 지연하거나 방지할 수 있는 일부 스레드 차단 메커니즘(e.g. DispatchSemaphore )
* (escaping) 지연 실행 (e.g. DispatchQueue.asyncAfter, UIViewPropertyAnimator.startAnimation(afterDelay:))
* (escaping) 시간초과가 긴 콜백(e.g. URLSession timeoutIntervalForResource )

첫번째 경우만 예제를 간단히 만들어 보았습니다.  ~~(적절한 예제인지는 ..)~~   
![화면 기록 2023-11-07 오후 9 59 50](https://github.com/jaehoon9186/study/assets/83233720/95f81dac-651b-4f54-a529-54086eb8bff8)   

이미지1) SecondVC 가 didLoad되면 Timer에 의해서 count가 10이 될때까지 작업을 수행하고 종료됩니다.   
해당 작업이 완료되기 전에 SecondVC를 탈출하면 SecondVC가 deallocate되지 않고 아직 메모리에 남아있음을 확인할 수 있습니다.  
물론 Timer의 작업이 완료가 되면 SecondVC.instance는 deallocate 됩니다. 
</br></br>


![화면 기록 2023-11-07 오후 10 05 06](https://github.com/jaehoon9186/study/assets/83233720/2cb1e609-359e-42a7-8bf6-b8faea4d7520)   

이미지2) [self weak] 캡처리스트를 사용해서 delayed deallocation을 해결합니다.  
SecondVC를 탈출하면 바로 deinit 되는 것을 볼 수 있습니다. 


## 3. in Nested Closure? 중첩 클로져 에서는?

복잡한 예제는 생각이 안나서 간단한 예제로 테스트해보겠습니다.  
중첩 클로저에서는 retain cycle이 발생했을때 어느 곳에 [weak self] 를 작성해야 할까요?  
```swift
firstFunc { // AAAAAAAAAAAAA
  self.doSomeThingElse()

  secondFunc { // BBBBBBBBBBBB
    self.doSomeThing()
  }
}
```
A지점? B지점? 아니면 둘다?  


```swift
class SomeClass {
    var closures: [()->Void] = []

    deinit {
        print("SomeClass.instance deallocate")
    }

    func start() {
        self.outer {
            self.doSomething("outer")

            self.inner {
                self.doSomething("inner")
            }
        }
    }

    private func outer(closure: @escaping () -> Void) {
        self.closures.append(closure)
        closure()
    }

    private func inner(closure: @escaping () -> Void) {
        self.closures.append(closure)
        closure()
    }

    private func doSomething(_ from: String) {
        print("\(from) closure, do Something")
    }
}

var a: SomeClass? = SomeClass()
a?.start()
a = nil
print("메모리 해제됨??")
```
<img width="824" alt="스크린샷 2023-11-08 오전 1 28 52" src="https://github.com/jaehoon9186/study/assets/83233720/143dbe2a-9863-482b-aa2a-66152b088ecc">

메모리가 deallocate 되었을때 보일 "SomeClass.instance deallocate" 출력문이 보이지 않습니다. retain cycle.   
( 중첩이 아닌 outer, inner 개별로 실행했을때도 메모리 누수가 발생합니다. 이때는 해당 클로저에 바로 [weak self]를 붙여주면 되죠 )    
  
결론은 최상위 escaping closure에만 작성하면됩니다. 상위 클로저에서 이미 retain cycle을 만들지 않기 때문에. 



```swift
func start() {
    self.outer { [weak self] in // 캡처리스트 작성
        self?.doSomething("outer")

        self?.inner {
            self?.doSomething("inner")
        }
    }
}
```
<img width="646" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/a2ac3221-d786-4b45-ace2-6bd26f4a57ae">   

정상적으로 deallocate 되었습니다. 
