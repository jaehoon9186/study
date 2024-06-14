# custom layout

- [https://developer.apple.com/videos/play/wwdc2022/10056/](https://developer.apple.com/videos/play/wwdc2022/10056/)
- [https://developer.apple.com/documentation/swiftui/layout](https://developer.apple.com/documentation/swiftui/layout)
- [https://swiftui-lab.com/layout-protocol-part-1/](https://swiftui-lab.com/layout-protocol-part-1/)
- [https://www.youtube.com/watch?v=WD7ebJZ7PaI](https://www.youtube.com/watch?v=WD7ebJZ7PaI)



# 어떻게 뷰들을 전달해, 일반 view 컨테이너 처럼 쓸 수 있는걸까?
- [SE-0253 / https://github.com/swiftlang/swift-evolution/blob/main/proposals/0253-callable.md](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0253-callable.md)


```swift
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Layout {

    /// Combines the specified views into a single composite view using
    /// the layout algorithms of the custom layout container.
    ///
    /// Don't call this method directly. SwiftUI calls it when you
    /// instantiate a custom layout that conforms to the ``Layout``
    /// protocol:
    ///
    ///     BasicVStack { // Implicitly calls callAsFunction.
    ///         Text("A View")
    ///         Text("Another View")
    ///     }
    ///
    /// For information about how Swift uses the `callAsFunction()` method to
    /// simplify call site syntax, see
    /// [Methods with Special Names](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID622)
    /// in *The Swift Programming Language*.
    ///
    /// - Parameter content: A ``ViewBuilder`` that contains the views to
    ///   lay out.
    ///
    /// - Returns: A composite view that combines all the input views.
    public func callAsFunction<V>(@ViewBuilder _ content: () -> V) -> some View where V : View

}
```





