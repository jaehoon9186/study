# List 다중 선택 구현 (EditButton 미사용).md

```swift

// State property
@State var viewMode: ViewMode = .browsing

@State var selection: Set<UUID> = []

// in body
List(selection: $selection) {
    ForEach(viewModel.rhythms, id: \.id) { rhythm in
        // Cell
    }
}

// view modifier
.toolbar { EditButton() } // 기존
.environment(\.editMode, viewMode == .selecting ? .constant(EditMode.active) : .constant(EditMode.inactive)) // 해결

// 참고
enum ViewMode {
    case browsing
    case editing
    case selecting
}

```

