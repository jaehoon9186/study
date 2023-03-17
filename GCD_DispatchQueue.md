# GCD

## 🥕 개념, 키워드?
[Dispatch](https://developer.apple.com/documentation/dispatch/). 
"Execute code concurrently on multicore hardware by submitting work to dispatch queues managed by the system."

GCD(Grand Central Dispatch) 멀티 코어 환경과 멀티 스레드 환경에서 최적화된 프로그래밍을 할 수 있도록 애플이 개발한 기술

Dispatch(프레임워크), Dispatch Queue(클래스)  


## main? global() ? 
### main?
Serial Queue  
메인 쓰레드에서 동작  
백그라운드 쓰레드에서 UI update를 할때 사용한다  
```swift
DispatchQueue.main.async {
    // TASK
}
```
main.sync 동작시 데드락 주의  
왜? 


### global() ? 
시스템의 글로벌 대기열  
할당한 테스크를 시스템이 알아서 기타쓰레드로 할당 후 처리  
qos 옵션으로 우선순위를 부여가능 [참고](https://developer.apple.com/documentation/dispatch/dispatchqos)  
concurrent Queue  


쇼핑 더보기 (2,686)

### 커스텀
사용자 정의로 큐를 만들수 있다. 기본옵션은 serial 큐이며 옵션으로 concurrent 큐를 만들수 있다.  
qos 옵션으로 우선순위를 정할수 있음.  

### 코드 
```swift
let queueList: [DispatchQueue] = [
    DispatchQueue.main,
    DispatchQueue.global(),
    DispatchQueue(label: "serial"),
    DispatchQueue(label: "concurrent", attributes: .concurrent)
]
// 0: main
// 1: global()
// 2: custom queue, serial
// 3: custom queue, concurrent
let queueNum = 3

print("Main 1")
queueList[queueNum].async {
    for _ in (0..<10) {
        print("🐯")
    }
}
//sleep(1)
print("Main 2")
queueList[queueNum].async {
    for _ in (0..<10) {
        print("🐼")
    }
}
print("Main 3")
```



## xcode thread sanitizer 옵션 
<img width="244" alt="스크린샷 2023-03-17 오후 4 15 33" src="https://user-images.githubusercontent.com/83233720/225837938-241cc896-0e46-4630-af0a-28e18b156741.png">
<img width="950" alt="스크린샷 2023-03-17 오후 4 16 01" src="https://user-images.githubusercontent.com/83233720/225838055-046230fe-a62e-4f2e-bcdf-4010aa393a37.png">

Thread Sanitizer 옵션 체크  
Thread Sanitizer—The TSan tool detects race conditions between threads.  
[참고](https://developer.apple.com/documentation/xcode/diagnosing-memory-thread-and-crash-issues-early)
