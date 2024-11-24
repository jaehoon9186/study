# Picker 기본 선택 오류 경험

```swift
// state property
@State private var selectedGroup: GroupModel?

// in body
Picker("Select Group", selection: $selectedGroup) {
    Section {
        Text("그룹을 선택하세요")
            .tag(Optional<GroupModel>(nil))
    }
    Section {
        ForEach(groupList, id: \.id) { group in
            Text(group.name)
                .tag(Optional(group))
        }
    }
}

// default setup
.onAppear {
    if case let .group(group) = viewModel.rhythmFilter {
        selectedGroup = group
    }
}

```


Picker 뷰에서 초기값을 설정했음에도 불구하고 메뉴 리스트에서는 항상 최상단 항목이 선택된 것으로 보였음. onAppear 모디파이어가 Form에 적용되어 Picker가 로드되기 전에 초기값이 설정된 때문이었음.
이를 해결하기 위해 onAppear 모디파이어의 위치를 Picker 뷰로 옮겼음.

간단한 초기화 작업은 onAppear의 위치를 조정하여 해결할 수 있었으며, 비동기 작업 또는 확실한 로드 이후에는 .task 모디파이어를 사용하여 초기값을 설정하도록 하자.
