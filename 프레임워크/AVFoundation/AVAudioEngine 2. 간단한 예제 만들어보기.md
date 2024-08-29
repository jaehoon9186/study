# AVAudioEngine 2. 간단한 예제 만들어보기

재생, 정지 버튼으로  간단한 음원을 반복재생, 정지 함.  

SwiftUI, MVVM 으로 구성.  

간단히 궁금증과 느낀점을 기록함.  


# resource 접근하기 
read-only인 번틀에 기본적으로 시스템에서 제공할 음원을 제공했음.  

URL로 접근 또는, path로 접근후 URL로 변환하면 됨.  

추후에 사용자가 음원을 녹음, 업로드 하게 되는 경우는 Documents에 저장해야 함. 이때는 FileManager를 이용해야 할 듯.  


# file or buffer

파일로 재생해야하나, 버퍼로 재생해야하나?  

파일 재생은 메모리효율적이지만 레이턴시가 있을 수 있음. 파일사이즈 등 외부 요인에 영향을 받는 듯.  

버퍼는 미리 메모리(RAM)에 로드해 놓고, 엔진에서 필요할때 버퍼의 데이터를 직접 재생해 빠른 속도를 보장, 레이턴시가 적음.  
단, 메모리 관리 전략이 필요할 듯. 새로운 버퍼를 로드 할 때마다 메모리에 누적 되도록 둘 순 없으니..  

버퍼를 nil로 설정하거나 버퍼를 참조하고 있는 변수를 해제 하면 ARC가 메모리를 해제 한다함. 


# View에서 ViewModel의 AudioManager를 직접 참조해도 될까?

@Observable 메크로를 사용해 ViewModel을 구성해서 맴버변수들이 @Published 와 같이 관찰해 업데이트되면 뷰에 반영되는데

View에서 직접적으로 AudioManager 내무로 접근하는것이 맞는지 잘 모르겠음..  

(audioEngine이 동작하는지 여부 .isRunning 메서드 제공함.)


# Session ? 



# 간혹 읽지 못하는 포멧이 존재하는 듯.. 

mp3인데 그냥 로드는 되는데 버퍼로 변환이 불가 했었음. 깊이 있게 확인하지는 못했고 다른 파일로 재생하는데 문제없이 재생됨.  

원인을 찾아봐야겠음.  


# 

```swift
import SwiftUI
import AVFAudio

class AudioManager {

    let audioEngine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    private var audioBuffer: AVAudioPCMBuffer?

    init() {
        setupAudio()
        setupSession()
    }

    private func setupAudio() {

        // url로 접근하는것, path로 접근해 URL로 변경하는것 뭐가 나아?
        guard let fileURL = Bundle.main.url(forResource: "Perc_Can_hi", withExtension: "wav") else {
            print("😲 ERROR: 오디오를 찾을 수 없음.")
            return
        }

        do {
            let audioFile = try AVAudioFile(forReading: fileURL)
            let format = audioFile.processingFormat

            if let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(audioFile.length)) {

                try audioFile.read(into: buffer)
                audioBuffer = buffer
            }

        } catch {
            print("😲 reading audio file ERROR: \(error.localizedDescription)")
            return
        }

        audioEngine.attach(playerNode)

        audioEngine.connect(playerNode, to: audioEngine.mainMixerNode, format: nil)
        audioEngine.prepare()
    }

    private func setupSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("😲 ERROR: Audio session setup failed: \(error.localizedDescription)")
        }
    }

    func playAudio() {
        guard let buffer = audioBuffer else { return }

        playerNode.scheduleBuffer(buffer, at: nil, options: [.loops]) {
            print("End playback")
        }

        do {
            if audioEngine.isRunning == false {
                try audioEngine.start()
            }

            playerNode.play()

        } catch {
            print("😲 audio Play ERROR: \(error.localizedDescription)")
        }

    }

    func stopAudio() {

        if audioEngine.isRunning {
            playerNode.stop()
            playerNode.reset() // 노드의 예약된 모든 재생을 취소하기 위함.
            audioEngine.stop()
        }
    }

}

@Observable
final class PlayerViewModel {
    var playerState: Bool = false

    let audioManager = AudioManager()

    func playButtonTapped() {
        audioManager.playAudio()
        playerState = true
    }

    func stopButtonTapped() {
        audioManager.stopAudio()
        playerState = false
    }
}


struct PlayerView: View {
    @State private var vm = PlayerViewModel()

    var body: some View {
        VStack {
            Text(vm.playerState ? "재생중" : "스탑")
            Text(vm.audioManager.audioEngine.isRunning ? "재생중" : "스탑") // 직접 audioEngine 상태로 뷰업데이트 해도 될까?

            HStack {
                Button("Play") {
                    vm.playButtonTapped()
                    print("play Button Tapped")
                }

                Button("Stop") {
                    vm.stopButtonTapped()
                    print("Stop Button Tapped")
                }
            }
        }
        .padding()
    }
}

#Preview {
    PlayerView()
}

```
