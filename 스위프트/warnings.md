
### * Class property 'current' is unavailable from asynchronous contexts; Thread.current cannot be used from async contexts.; this is an error in Swift 6
<img width="834" alt="스크린샷 2023-07-14 오후 5 32 23" src="https://github.com/jaehoon9186/study/assets/83233720/e217698a-2868-4a35-a575-8505982098b1">  

동시성을 공부하며 나타난 에러..  


[링크1](https://forums.swift.org/t/pitch-unavailability-from-asynchronous-contexts/53877)  
[링크2](https://stackoverflow.com/questions/73790307/class-property-current-is-unavailable-from-asynchronous-contexts-thread-curre)

> How to fix?

[youtube conmment](https://www.youtube.com/watch?v=-5kIzkBqAzc&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=4)
```swift
func addAuthor1() async {
    let author1 = "Author1 : \(Thread())"
}
```
