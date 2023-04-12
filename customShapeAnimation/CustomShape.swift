//
//  ContentView.swift
//  customShapeAnimation
//
//  Created by Farhad Bagherzadeh on 23/1/2023.
//

import SwiftUI

struct Trapezoid: Shape {
  var insetAmount: Double

  var animatableData: Double {
    get { insetAmount }
    set { insetAmount = newValue }
  }

  func path(in rect: CGRect) -> Path {
    var path = Path()

    path.move(to: CGPoint(x: 0, y: rect.maxY))
    path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: 0, y: rect.maxY))
    path.closeSubpath()

    return path
  }
}

struct CustomShape: View {
  @State private var insetAmount = 50.0

  var body: some View {
    Trapezoid(insetAmount: insetAmount)
      .stroke()
      .frame(width: 200, height: 100)
      .contentShape(Rectangle())
      .onTapGesture {
        withAnimation {
          insetAmount = Double.random(in: 10...90)
        }
      }
  }
}

struct CustomShape_Previews: PreviewProvider {
  static var previews: some View {
    CustomShape()
  }
}
