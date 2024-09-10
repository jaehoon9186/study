# array observing

<p align="center"> 
  <img width="250"  src="https://github.com/user-attachments/assets/b0e529a4-cdc6-4933-bf3e-5579ee56b531">
</p>

SwiftUI에서 dot인스턴스들로 구성된 2차원 어레이의 관찰을 구현해 보았음.  

forEach에서 사용하려면 Identifiable 프로토콜을 채택해주어야함.  
(hashable은 나중에 딕셔너리사용할때 키값으로 사용할수 있도록 채택해줬음)  

forEach로 구성된 circle 뷰에서 dot 인스턴스를 수정하려고 했으나 수정이 불가함. 상수로 전달 되기때문.  

그래서 $키워드를 사용해 바인딩으로 전달받아보았음.  

dot 객체 하나중 속성하나가 변경이되어서 UI의 변경이 이뤄지면  
row 하나의 열 전체가 깜박거리는 현상이 발생함.  

그래서 index로 직접 수정하도록함.  


뷰에서 변경사항을 관찰하기 위해 .onChange 모디파이어를 사용했음.  

iOS17은 클로저에 0개 또는 2개(oldValue, newValue) 매개변수를 사용함. 
이전버전은 1개만.  




```swift

@Observable
class TestViewModel {
    var dots: [[Dot]] = [
        [Dot(), Dot(), Dot()],
        [Dot(), Dot()],
        [Dot(), Dot(), Dot(), Dot()]
    ]

    func randomAnimated() {
        let randomRow = (0..<dots.count).randomElement()!
        let randomCol = (0..<dots[randomRow].count).randomElement()!
        dots[randomRow][randomCol].isRandomAnimated = true
    }

}

struct Dot: Hashable, Identifiable {
    let id = UUID()
    var isTapAnimated = false
    var isRandomAnimated = false
}

struct arrayObserveView: View {
    @State var vm = TestViewModel()

    var body: some View {
        VStack {
            ForEach(vm.dots.indices, id: \.self) { rowIndex in

                HStack {
                    ForEach(vm.dots[rowIndex].indices, id: \.self) { colIndex in

                        Circle()
                            .fill(.orange)
                            .frame(width: 60, height: 60)
                            .scaleEffect(vm.dots[rowIndex][colIndex].isTapAnimated ? 0.9 : 1.0)
                            .shadow(color: .red, radius: vm.dots[rowIndex][colIndex].isRandomAnimated ? 10 : 0)
                            .onTapGesture {
                                vm.dots[rowIndex][colIndex].isTapAnimated = true

                                withAnimation(.spring) {
                                    vm.dots[rowIndex][colIndex].isTapAnimated = false
                                }
                            }
                            .onChange(of: vm.dots[rowIndex][colIndex].isRandomAnimated) { oldValue, newValue in
                                if newValue == true {
                                    print("\(rowIndex), \(colIndex) It's NEW")
                                    withAnimation(.linear) {
                                        vm.dots[rowIndex][colIndex].isRandomAnimated = false
                                    }
                                }
                            }
                    }
                }
            }

            Button("랜덤 애니메이션") {
                vm.randomAnimated()
            }
        }
    }
}

#Preview {
    arrayObserveView()
}

```
