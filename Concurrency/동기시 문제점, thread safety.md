# 동기 프로그래밍시 발생할 수 있는 문제점과, 해결방안

## 🐯 문제점

### 1. Data races (데이터 경쟁 상태, == data race condition ?)
[Data Races doc](https://developer.apple.com/documentation/xcode/data-races)  
여러 쓰레드가 동기화 없이 동일한 메모리에 엑세스 할 때 서로 경쟁하는 상황


### 2. Dead Lock (교착상태)


## 🐯 해결, Thread Safety

### 1. Semaphore / critical section (임계구역)

#### 참고: Mutax

### 2. Dispatch Group

### ?. NSLock

### ?. Data Isolation, Actor Isolation, Task Isolation?

## 🎸 기타, xcode에서 미리 발생할 문제를 감지 할 방법은?
