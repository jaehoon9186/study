# in concurrency, ui 업데이트가 안되는 문제

- [https://forums.developer.apple.com/forums/thread/761618](https://forums.developer.apple.com/forums/thread/761618)

글로벌 스레드로 SwiftData를 업데이트하려면 modelActor를 거쳐 구성하면되는데. 모델이 업데이트되어도 ui에 반영이 안되는 문제 . 

애플에선 조치중인것 같음..

링크에서는 mv 아키텍쳐에서의 적용을 예로 보여줌. 

난 mvvm이여서 

combine을 사용해 적용해봄. 

```swift
extension NotificationCenter {
    var managedObjectContextDidSavePublisher: Publishers.ReceiveOn<NotificationCenter.Publisher, DispatchQueue> {
        return publisher(for: .NSManagedObjectContextDidSave).receive(on: DispatchQueue.main)
    }
}

// in vm
// bind method
NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
  .receive(on: DispatchQueue.main)
  .sink { [weak self] fetch in
      self?.updateBarViewModels() // 기존 fetch 로직활용. 
  }
  .store(in: &cancellables)

```

이하처럼 임시로 fetch 메서드를 구성해 봤는데 생각해보니 vm에 fetch용으로 구성된 메서드를 사용하면 되는것있었음.  

fetch method를 구성해 뷰에 보여질 타입을 반환받는것이 일반적인 흐름인것 같긴함...   

```swift
func fetchBars(rhythm: RhythmModel) -> [BarModel] {
    // 이것도  persistentModelID를 파라미터로 받는게? 
    guard let rhythm = self[rhythm.persistentModelID, as: RhythmModel.self] else {
        print("dont have rhythm")
        return []
    }

    let predicate = #Predicate<BarModel> { bar in
        if let parentRhythm = bar.rhythm {
            return parentRhythm == rhythm
        }
        return false
    }

    let descriptor = FetchDescriptor(predicate: predicate)

    let idAndIndexDictionary = Dictionary(uniqueKeysWithValues: rhythm.barIds.enumerated().map { ($1, $0) } )

    do {
        let bars = try context.fetch(descriptor)
        let sortedBars = bars.sorted { bar1, bar2 in
            guard let bar1Index = idAndIndexDictionary[bar1.id],
                    let bar2Index = idAndIndexDictionary[bar2.id] else {
                return false
            }
            return bar1Index < bar2Index
        }
        return sortedBars
    } catch {
        return []
    }
}
```
나중에 다시 참고해보자. 
