# Audio Session

- [https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Introduction/Introduction.html](https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Introduction/Introduction.html)




# AudioSession? 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/5e38ae66-5477-4621-8026-0da780b5ceba">
</p>


오디오세션은 앱과 OS의 오디오시스템의 중개자의 역할을 함. 



다른 앱들의 오디오 출력이 있을때의 충돌, 우선순위를 관리.  
오디오의 입/출력 경로 관리. (디바이스, 블루투스, 이어폰, AirPlay 등)  
백그라운드 동작을 가능하게 함.  
전화, 알림 시에 어떻게 처리할건지 를 관리함.  




예를들어, 뮤직앱은 백그라운드에서 동작해야함.  
녹음 앱은 녹음동작시에 출력을 하지 않아야함.  
이러한 동작이 필요할 때와 같은 오디오의 관리를 오디오 세션에 위임하여 사용자의 오디오 경험을 최적으로 관리할 수 있게 됨.  



# 활성화 / Activating an Audio Session.
- [https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/ConfiguringanAudioSession/ConfiguringanAudioSession.html#//apple_ref/doc/uid/TP40007875-CH2-SW1](https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/ConfiguringanAudioSession/ConfiguringanAudioSession.html#//apple_ref/doc/uid/TP40007875-CH2-SW1)


먼저, OS는 어떤 방식으로 여러 앱들간의 오디오를 관리할까?


<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/1a5b38cf-91da-47b3-b2c0-de52c124c968">
</p>

공항 = 디바이스(아이폰, 애플워치 등) / 비행기들 = 다양한 앱들 / 컨트롤 타워 = OS.  

비행기가 지나가겠다 요청을 할 수 있지만, 그것을 허락하는 것은 컨트롤 타워임.  

앱(비행기)가 요청을 할때는 AudioSession을 통해 요청을 하고 OS에 의해 통제됨.  

---

그럼, 앱이 가지고있는 오디오세션을 어떻게 활성화 할까?  


AVAudionSession 이라는 싱글톤 객체를 제공함.

싱글톤 객체를 사용해 원하는 동작을 제공하도록 구성하고 active 하도록 하자.  

```swift
let session = AVAudioSession.sharedInstance()
do {
    // 1) Configure your audio session category, options, and mode
    // 2) Activate your audio session to enable your custom configuration
    try session.setActive(true)
} catch let error as NSError {
    print("Unable to activate audio session:  \(error.localizedDescription)")
}
```


AVFoundation의 playback, recording 클래스는 세션을 자동으로 활성화 한다고함.  
(저수준인 coreAudio나 AudioEngine의 노드들도 그런지 알아봐야 갰음)  

세션을 메뉴얼리하게 활성화하는 경우는 개발자에게 테스트 할 수 있는 기회를 제공하는 것  
()

수동으로 활성화 하려면 setActive() 메서드로 true를 보내주셈.  

직접적으로 false를 사용하는 경우는 거의 없다함. (os가 알아서 헨들링 해줘서 그럴까?)  

예를들어, 전화가 오거나 알림이 오거나 할때 OS는 사용중인 앱의 오디오 세션을 비활성화 함.  






# 세션설정옵션들 / category and mode
- [https://developer.apple.com/documentation/avfaudio/avaudiosession](https://developer.apple.com/documentation/avfaudio/avaudiosession)

세션은 어떤 옵션들을 제공할까?  








# 방해할때 / Interruption

- [https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/HandlingAudioInterruptions/HandlingAudioInterruptions.html#//apple_ref/doc/uid/TP40007875-CH4-SW6](https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/HandlingAudioInterruptions/HandlingAudioInterruptions.html#//apple_ref/doc/uid/TP40007875-CH4-SW6)



# 







---


# 언제 세션을 활성화 하는 것이 좋을까?

시나리오에 따라 고려할 수 있을 것 같다. 

오디오 재생 빈도에 따라? 

유튜브 뮤직 앱의 경우는 재생버튼을 탭할때 세션을 정해전 설정으로 활성화 하는것 같음. 






