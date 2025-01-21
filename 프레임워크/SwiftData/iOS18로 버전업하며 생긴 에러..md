# iOS18로 버전업하며 생긴 에러.md



```
SwiftData/BackingData.swift:663: Fatal error: This model instance was destroyed by calling ModelContext.reset
and is no longer usable.
PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID
(url: x-coredata://1A6DBCF8-F4F8-4762-9D6B-62BCA847D1A1/GroupModel/p1),
implementation: SwiftData.PersistentIdentifierImplementation)
```

이런 에러가 나옴.. 

iOS17에선 잘 돌아갔는데.. 18로 업뎃하며 이런 에러가 생김. 

기존상황 
modelActor를 통해 직렬로 처리함. modelContainer의 인스턴스를 vm 끼리 di 함. 
콘테이너는 app사이클 단계에서 생성함. 

문제? 모델액터의 인스턴스가 액터의 라이프사이클이 종료된 후에도 유지되고 있으면 발생하는듯.

- [https://forums.developer.apple.com/forums/thread/757521](https://forums.developer.apple.com/forums/thread/757521)


액터를 싱글톤으로? 


```swift
ModelActor
actor DataHandler {

    private var context: ModelContext { modelExecutor.modelContext }

    static let shared = DataHandler()

    private init() {
        let schema = Schema([
            GroupModel.self, RhythmModel.self, BarModel.self,
            LineModel.self, BeatModel.self, NoteModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let modelContainer =  try! ModelContainer(for: schema, configurations: modelConfiguration)

        DispatchQueue.main.async {
            modelContainer.mainContext.autosaveEnabled = false
        }
        
        let modelContext = ModelContext(modelContainer)
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
        self.modelContainer = modelContainer
    }

    // ...
}
```

일단 이렇게해봄. 
forums.developer.apple 에는 클래스로 메인액터로 싱글톤으로 햇는데.   

@ModelActor 메크로를 사용하고 싶었음. 시리얼하며 여러개의 스레드를 사용할수 있어서..  

@ModelActor 메크로를 채택하면 기본 구현으로 
```swift
init(modelContainer: SwiftData.ModelContainer) {
    let modelContext = ModelContext(modelContainer)
    self.modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
    self.modelContainer = modelContainer
}
```

이렇게 init이 기본구현되어 있는데 이걸 싱글톤으로 구현시에 어떻게 막아야할지 모르겠음...  

팩토리 패턴으로 다른 클래스로 생성하도록 하던가 해야할듯. 


