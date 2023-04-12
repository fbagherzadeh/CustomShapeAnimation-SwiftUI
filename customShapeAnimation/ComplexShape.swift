//
//  ComplexShape.swift
//  customShapeAnimation
//
//  Created by Farhad Bagherzadeh on 23/1/2023.
//

import SwiftUI

struct Flower: Shape {
  var petalOffset: Double = -20 // How much to move this petal away from the center
  var petalWidth: Double = 100 // How wide to make each petal

  var animatableData: AnimatablePair<Double, Double> {
    get {
      AnimatablePair(petalOffset, petalWidth)
    }
    set {
      petalOffset = newValue.first
      petalWidth = newValue.second
    }
  }

  func path(in rect: CGRect) -> Path {
    // The path that will hold all petals
    var path = Path()

    // Count from 0 up to pi * 2, moving up pi / 8 each time
    for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
      // rotate the petal by the current value of our loop
      let rotation = CGAffineTransform(rotationAngle: number)

      // move the petal to be at the center of our view
      let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

      // create a path for this petal using our properties plus a fixed Y and height
      let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

      // apply our rotation/position transformation to the petal
      let rotatedPetal = originalPetal.applying(position)

      // add it to our main path
      path.addPath(rotatedPetal)
    }

    // now send the main path back
    return path
  }
}

struct ComplexShape: View {
  @State private var petalOffset = -20.0
  @State private var petalWidth = 100.0

  var body: some View {
    VStack {
      Flower(petalOffset: petalOffset, petalWidth: petalWidth)
        .stroke(.red, lineWidth: 1)
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation {
            petalOffset = Double((-40...40).randomElement() ?? -40)
            petalWidth = Double((0...100).randomElement() ?? 0)
          }
        }


      Text("Offset")
      Slider(value: $petalOffset, in: -40...40)
        .padding([.horizontal, .bottom])

      Text("Width")
      Slider(value: $petalWidth, in: 0...100)
        .padding(.horizontal)
    }
  }
}

struct ComplexShape_Previews: PreviewProvider {
  static var previews: some View {
    ComplexShape()
  }
}
