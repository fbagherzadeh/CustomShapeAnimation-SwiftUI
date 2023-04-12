
## Why animation doesn’t work without `animatableData` property?
- When changing a view's state property(with animation applied), SwiftUI is examining the state of our view before the binding changes, examining the target state of our views after the binding changes, then applying an animation to get from point A to point B.
 - In our example, when `insetAmount` is set to a new random value, it will immediately jump to that value and pass it directly into Trapezoid – it won’t pass in lots of intermediate values as the animation happens.
 - Basically, our trapezoid has no idea an animation is even happening.


## How `animatableData` fixing it?
 - When using `withAnimation()`, SwiftUI immediately changes our state property to its new value, but behind the scenes it’s also keeping track of the changing value "over time" as part of the animation; as the animation progresses, SwiftUI will set the animatableData property of our shape to the latest value...


## Cool fill modifier with even-odd rule!
`.fill(.red, style: FillStyle(eoFill: true))`


## When our custom Shape has `Int` type properties
 - SwiftUI can’t interpolate integers
```
var animatableData: AnimatablePair<Double, Double> {
    get {
       AnimatablePair(Double(rows), Double(columns))
    }

    set {
        rows = Int(newValue.first)
        columns = Int(newValue.second)
    }
}
```


## How do we animate three properties? Or four?
- Similar to `EdgeInsets` in SwiftUI module
- AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>>
- Accessing the newValue would be something like `newValue.second.second.first`


## Links
- https://www.hackingwithswift.com/books/ios-swiftui/transforming-shapes-using-cgaffinetransform-and-even-odd-fills
- https://www.hackingwithswift.com/books/ios-swiftui/animating-simple-shapes-with-animatabledata
- https://www.hackingwithswift.com/books/ios-swiftui/animating-complex-shapes-with-animatablepair
