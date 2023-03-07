# Concurrency Programming 동시성프로그래밍

## 🥕 동시성 프로그래밍이란?
[Concurrency apple documentation](https://developer.apple.com/documentation/swift/concurrency)  
[애플 생태계 속의 동시성 프로그래밍 기술](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html)  
[Grand Central Dispatch](https://developer.apple.com/documentation/dispatch) 

GCD?, Operation? iOS에서 대기행렬의 개념 


## 🥕 왜 동시성 프로그래밍이 필요할까?
최적화를 위해, 예를 들어 인스타그램이 한개의 쓰레드로 동작한다면 사진을 스크롤하며 로딩하는 시간이 엄청나게 길어질 것. 

네트워크 처리는 1번 스레드가 아닌 다른 스레드로 처리해주는 것이 좋다. 


## 🥕 헷갈리지마 (동기 vs 비동기, 직렬 vs 동시성, 병렬성 프로그래밍)
#### 🍇 동기 프로그래밍 ( Sync ) 
프로그램의 흐름과 이벤트 발생 및 처리를 동속적으로 수행하는 방법  
***" 기다린다 "*** </br>
<img width="735" alt="image" src="https://user-images.githubusercontent.com/83233720/223357589-3890c40e-b17c-4c4c-92f0-23693f816836.png">


#### 🍇 비동기 프로그래밍 ( Async ) 
프로그램의 흐름과 이벤트의 발생 및 처리를 독립적으로 수행한는 방법. 
대부분 네트워크 작업 때문에 필요하다.  
***" 안 기다린다 "***</br>
<img width="735" alt="image" src="https://user-images.githubusercontent.com/83233720/223358075-1c4dd02d-9994-48ae-9d4d-79debd231400.png">


#### 🧀 직렬 프로그래밍 ( Serial ) 
작업의 순서가 중요한 경우  
<img width="735" alt="image" src="https://user-images.githubusercontent.com/83233720/223360336-36ad6a00-1cba-4952-b589-8955d0a206b7.png">


#### 🧀 동시성 프로그래밍 ( Concurrency ) 
여러 작업이 논리적인 관점에서 동시에 수행되는 것 처럼 보이도록 하는 것  
싱글 코어 또는 멀티 코어에서 멀티 스레딩을 하기 위해 적용. 
<img width="735" alt="image" src="https://user-images.githubusercontent.com/83233720/223360604-740d941b-2c47-4849-b264-f1e8a9832485.png">



#### 🧀 병렬성 프로그래밍 ( Parallel ) 
여러 작업이 물리적인 관점에서 동시에 수행되는 것

## 🥕 간단 예제?









