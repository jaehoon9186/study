# 에러 Thread 1: EXC_BAD_ACCESS


```Thread 1: EXC_BAD_ACCESS (code=1, address=0x8000000000000010)```


<img width="1447" alt="스크린샷 2025-01-24 오전 2 51 13" src="https://github.com/user-attachments/assets/0c165eb9-8546-48ac-890e-9b8bd4635f74" />

유효하지 않은 메모리를 참조할때 발생하는 것 같다.  
이미 메모리에서 해제되거나 하는 등의.. 

아으.. 


시도해본 경험.  
1. ㅇ   
- [https://jhnjslee.tistory.com/2](https://jhnjslee.tistory.com/2)
이걸 참고해서 좀비클래스? 들이 있는지 확인해봄.  

2. ㅇ

비슷한 구조의 nested 클래스로 모델이 구성되어 있음 ..  

자식들은 부모를 약한 참조로 갖게해 부모가 해제시에 자식도 해제되도록.  

부모를 weak var로 약한 참조를 하도록함. 

3. ㅇ

```swift
// in swiftData Model
private(set) var beats: [BeatModel] = []
private(set) var beatIds: [UUID] = []
```
자꾸 getter부분에서 랜덤으로 에러가나는거 보니까  

외부에선 get만 가능하도록 private(set)로 맴버변수들을 갖는데..  

비동기 환경에서 get을 할시에 이미 메모리에서 해제된경우가 발생하지 않을까 싶음..  

private로 바꿔 보자. 

