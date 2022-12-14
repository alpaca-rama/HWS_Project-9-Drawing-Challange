//
//  ContentView.swift
//  Project-9-Drawing-Challange
//
//  Created by Luca Capriati on 2022/08/30.
//
// Project 9 - Challange 1 - Create an Arrow shape – having it point straight up is fine. This could be a
//  rectangle/triangle-style arrow, or perhaps three lines, or maybe something else depending on
//  what kind of arrow you want to draw.
// Project 9 - Challange 2 - Make the line thickness of your Arrow shape animatable.
// Project 9 - Challange 3 - Create a ColorCyclingRectangle shape that is the rectangular cousin of
//  ColorCyclingCircle, allowing us to control the position of the gradient using one or more
//  properties.

import SwiftUI
// Project 9 - Challange 1 & 2
//// Project 9 - Challange 1
//struct Arrow: Shape {
//    var headHeight = 0.5
//    var shaftWidth = 0.3
//
//    // Project 9 - Challange 2
//    var animatableData: AnimatablePair<Double, Double> {
//        get { AnimatablePair(headHeight, shaftWidth) }
//        set {
//            headHeight = newValue.first
//            shaftWidth = newValue.second
//
//        }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        let height = rect.height * headHeight
//        let thickness = rect.width * shaftWidth / 2
//
//        return Path { path in
//            path.move(to: CGPoint(x: 0, y: height))
//            path.addLine(to: CGPoint(x: rect.midX, y: 0))
//            path.addLine(to: CGPoint(x: rect.maxX, y: height))
//            path.addLine(to: CGPoint(x: rect.midX + thickness, y: height))
//            path.addLine(to: CGPoint(x: rect.midX + thickness, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.midX - thickness, y: height))
//
//            path.closeSubpath()
//
//        }
//    }
//}
//
//
//    struct ContentView: View {
//        // Project 9 - Challange 2
//        @State private var headHeight = 0.5
//        @State private var shaftWidth = 0.25
//
//        var body: some View {
//            // Project 9 - Challange 2
//            Arrow(headHeight: headHeight, shaftWidth: shaftWidth)
//                .fill(.indigo)
//                .onTapGesture {
//                    withAnimation {
//                        headHeight = Double.random(in: 0.2...0.8)
//                        shaftWidth = Double.random(in: 0.2...0.8)
//                    }
//                }
//        }
//}

// Project 9 - Challange 3
struct ColourCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var gradientStartX = 0.5
    var gradientStartY = 0.0
    var gradientEndX = 0.5
    var gradientEndY = 1.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),
                            ]),
                            startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
                        ),
                        lineWidth: 2
                        )
            }
        }
        // This modifier greatly improves the performance of the render.
        // try remove it and see the difference
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
    
    @State private var gradientStartX = 0.5
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 1.0
    
    var body: some View {
        VStack {
            ColourCyclingRectangle(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                .frame(width: 300, height: 300)
            
            HStack {
                Text("Color")
                Slider(value: $colorCycle)
            }
            
            HStack {
                Text("Start X")
                Slider(value: $gradientStartX)
            }
            
            HStack {
                Text("Start Y")
                Slider(value: $gradientStartY)
            }
            
            HStack {
                Text("End X")
                Slider(value: $gradientEndX)
            }
            
            HStack {
                Text("End Y")
                Slider(value: $gradientEndY)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
