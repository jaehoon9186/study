# custom layout 2, 원형 레이아웃 구현해보자.md

- [https://www.youtube.com/watch?v=BU7-CfyNEM4](https://www.youtube.com/watch?v=BU7-CfyNEM4)

구현하고자 하는 앱에 레이아웃이 원형이고 원형에 필요한 갯수에 따라 동일한 간격으로 배치 하길 원했음. 

<p align="center">
  <img width="946" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/f0cdba40-484b-453a-a7c6-b8da0d37c269">
</p>


빨간원은 검은원 뒤쪽에 위치해 정해진 시간에 맞춰 점선을 따라 회전하도록  

ZStack으로 이해해 보면 **원형선 - 빨간원 1개 - 검은원 n개** 순으로  

최종적으로는 m개의 원형선이 배치 되도록  

(원형선은 크기가 동적이고, 나머지는 정적으로 고정, 빨간원만 회전 애니메이션)  


#  

원형 배치 레이아웃

```
struct RadicalLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = min(bounds.width, bounds.height) / 2
        let angle = Angle.degrees(360 / Double(subviews.count)).radians

        for (index, subview) in subviews.enumerated() {
            let viewSize = subview.sizeThatFits(.unspecified)

            let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
            let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)

            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)

            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}
```
