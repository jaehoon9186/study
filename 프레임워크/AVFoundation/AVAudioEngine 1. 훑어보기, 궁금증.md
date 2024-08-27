# AVAudioEngine 1. 훑어보기, 궁금증

오디오를 규칙적으로 재생할 필요가 있어 알아보게 됨.  

Timer를 사용하려고 했으나 백그라운드로 동작하거나 등 여러 메모리를 사용시에 우선순위가 떨어져 정확도가 부족하다고 해서..  

AVFAudio 프레임워크의 AVAudioEngine을 사용하거나, AVFoundation을 사용하려고함.  

-> AVAudioEngine이 AVFoundation에도 있어서 찾아보니.. 같은것 같음...  
-> AVFoundation은 오디오 비디오를 모두 포함한다면, AVFAudio는 AVFoundation의 하위 모듈로 오디오만 포함하는것. 


AVKit도 있는데 하단에 AVFoundation이랑 비교해봄.  


나는 AVAudioEngine 필요함.  
왜? 
멀티 트랙 재생  
틱사운드 딜레이 조정(오디오 그래프? 어떻게 보여줄 수 있을까? 편집기 형식으로 보여줄 수 있을까?)(블루투스이어폰, 커스텀 트랙 사용 시)  
3D audio? RL or 2개이상일때 서라운드로? in-ear 사용시  


 

# AVAudioEngine

- [https://developer.apple.com/documentation/avfaudio/audio_engine#overview](https://developer.apple.com/documentation/avfaudio/audio_engine#overview)
- [502 sd avaudioengine in practice / WWDC14 / 본영상은 지워진 듯](https://www.youtube.com/watch?v=FlMaxen2eyw)

 

![image](https://github.com/user-attachments/assets/11ad259c-d540-4ae6-aab2-480d5389d215)


AVAudioEngine 는 다양한 AVAudioNode 인스턴스들을 포함하는 오브젝트  

다양한 audioNode 들이 있는데 오디오 소스가 해당 노드들을 거쳐 변환되어 출력이 됨.  


엔진, 노드 만들고  

엔진에 노드추가 연결 하고  

노드에서 어떤 오디오 파일을 재생할지 예약하고 

엔진 노드 순으로 시작  

노드 엔진 순으로 스탑  

```swift
let audioFile = /* An AVAudioFile instance that points to file that's open for reading. */
let audioEngine = AVAudioEngine()
let playerNode = AVAudioPlayerNode()


// Attach the player node to the audio engine.
audioEngine.attach(playerNode)


// Connect the player node to the output node.
audioEngine.connect(playerNode, 
                    to: audioEngine.outputNode, 
                    format: audioFile.processingFormat)
```

```swift
playerNode.scheduleFile(audioFile, 
                        at: nil, 
                        completionCallbackType: .dataPlayedBack) { _ in
    /* Handle any work that's necessary after playback. */
}
```

```swift
do {
    try audioEngine.start()
    playerNode.play()
} catch {
    /* Handle the error. */
}
```

```swift
playerNode.stop()
audioEngine.stop()
```



대강 이런 느낌인것 같음.  

간단하게 예제를 만들어 봐야겠음.  ㄹ

---
* 
1. Create an engine
2. Create nodes
3. Attach nodes to the engine
4. Connect the nodes together
5. Start the engine

---
* 추가




# 노드?

```swift
            APP
    |                 |             |
inputNode    -> mainMixerNode -> outputNode >>> 출력
playerNode   ->
```

이런식으로 이해햇음. 

여기에 다양한 노드들을 붙여서 소스를 믹싱할 수 있음.  
APP에서도 real-time으로 각 노드를 통제할 수 있음.  


inputNode, mainMixerNode, outputNode < 얘네들이 engine에 연결되어 있는 기본 노드들이고  
여기에 외부 노드들을 추가로 연결 가능함.  



AVAudioNode 클래스의 자식 클래스들임.  

input, output에 특정하여 연결하기도 하는 것 같다. 문서참조ㄱㄱ  


# with TCA ?

일반적으로 싱글톤으로 구성하는것 같음.  
잘 알듯이 싱글톤은 쉽게 구성할 수 있다는 장점이 있지만, 테스트 하기 용이하지 않다는 단점이 있음.  

TCA를 공부중인데 어떻게 적용하면 좋을지 고민중임.  

테스트 하기 용이해야하고, 다양한 reducer에서 여러번 호출이 되야한다면 코드의 중복을 방지하고 싶고...   



- [https://green1229.tistory.com/485](https://green1229.tistory.com/485)

어떻게 적용하는게 좋을까?  

Dependency 주입하는것이?  

Environment를 이용?  




# AVKit vs AVFoundation ?

* AVKit
  * 고수준 (쉽게 사용할 수 있도록 추상화된 인터페이스를 제공, 내부적으론 복잡한 로직 수행)
  * 간단하게 단순한 재생 기능 구현가능. 
  * AVPlayerViewController, AVPlayerView 등을 사용해 쉽게 비디오/오디오 재생 UI 구현 가능.


* AVFoundation
  * 저수준
  * 오디오/비디오의 재생, 녹음, 편집, 변환 등 고급 기능을 제공
  * 세부제어 처리를 필요로 할 때


AVKit이 AVFoundation 위의 계층에 존재? 

AVKit > AVFoundation > AVFAudio 인가?
