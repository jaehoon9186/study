# Escaping 클로저 (@escaping)


[도큐먼트](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)

@escaping 키워드를 왜 사용하나? 클로저가 함수의 인자로 전달되고나서 전달된 클로저가 바로 실행되는 것이 아닌 나중에 실행되거나 비동기로 실행될 필요가 있을경우(함수의 흐름에 상관 없이)에 @escaping 키워드를 사용한다.
MVVM패턴에서 Observable 오브젝트를 만들어 바인딩 하는경우나 api 호출하는 경우 봤던것 같다. 

> CODE
```swift
class SomeClass {
    var x = 10
    var completionHandler: (() -> Void)?


    // func의 life cylcle에 벗어나 실행시키는 경우 @escaping키워드가 필요하다.
    func funcEscapingClosure(_ closure: @escaping () -> Void) {
        completionHandler = closure
    }

    func funcNoneEscapingClosure(_ closure: () -> Void) {
        closure()
    }

    func doSomething() {
        /*
         클래스 내부에서 escaping closure를 사용하여 내부 변수를 참조하기위해선 특별한 고려가 필요하다.
         왜 ? 강한 참조 사이클(strong reference cycle)이 실수로 만들어 질 수 있기 때문.

         어떻게 해결할까 ? 명시적으로 표현함으로써 해결한다.
         1. 멤버변수에 self 키워드를 사용하거나
         2. 클로저의 캡처 리스트에 self 키워드를 사용한다.

         */
//        funcEscapingClosure { x = 100 } // ERROR
        funcEscapingClosure { self.x = 100 } // OK. 1.
//        funcEscapingClosure { [self] in x = 100 } // OK. 2.

        funcNoneEscapingClosure { x = 200 }
    }


}


let c = SomeClass()

c.doSomething()
// funcNoneEscapingClosure 만 실행됨.
print(c.x) // 200

// 저장된 핸들러 실행.
c.completionHandler?()
print(c.x) // 100
```

